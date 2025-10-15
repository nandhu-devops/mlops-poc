# app.py — YouTube comment scraper without API key
import os
import csv
import io
import time
from typing import Optional, List
from fastapi import FastAPI, Query, HTTPException
from pydantic import BaseModel
from datetime import datetime
import boto3

# Try to import the scraper library
try:
    from youtube_comment_downloader import YoutubeCommentDownloader
except Exception as e:
    YoutubeCommentDownloader = None

S3_BUCKET = os.getenv("S3_BUCKET")
S3_PREFIX = os.getenv("S3_PREFIX", "datasets")
REGION = os.getenv("AWS_REGION", "us-east-1")
LOCAL_OUT = os.getenv("LOCAL_OUT", "/data/youtube_comments.csv")

app = FastAPI(title="yt-ingest-scraper", version="0.3")


def extract_video_id(url_or_id: str) -> str:
    import re
    m = re.search(r"(?:v=|/shorts/|youtu\.be/)([A-Za-z0-9_\-]{6,})", url_or_id)
    if m:
        return m.group(1)
    return url_or_id


# ✅ Resilient version (handles all downloader variants)
def scrape_comments(video_id_or_url: str, max_comments: int = 200, sleep_between_requests: float = 0.5) -> List[dict]:
    """
    Robust wrapper that calls whichever comment iterator method the installed
    youtube-comment-downloader exposes.
    Accepts either full video URL or video id.
    """
    if YoutubeCommentDownloader is None:
        raise RuntimeError("youtube_comment_downloader not installed in this image")

    downloader = YoutubeCommentDownloader()

    # Possible callable methods — different versions expose different names
    candidates = [
        ("get_comments_from_video_id", lambda v: downloader.get_comments_from_video_id(v)),
        ("get_comments_from_url", lambda v: downloader.get_comments_from_url(v)),
        ("get_comments", lambda v: downloader.get_comments(v)),
        ("get_comments_from_url_or_id", lambda v: downloader.get_comments_from_url_or_id(v)),
    ]

    iterator = None
    for name, fn in candidates:
        if hasattr(downloader, name):
            try:
                video_url = video_id_or_url
                if not video_id_or_url.startswith("http"):
                    video_url = f"https://www.youtube.com/watch?v={video_id_or_url}"
                iterator = fn(video_url)
                break
            except TypeError:
                try:
                    iterator = fn(f"https://www.youtube.com/watch?v={video_id_or_url}")
                    break
                except Exception:
                    continue

    if iterator is None:
        available = [attr for attr in dir(downloader) if callable(getattr(downloader, attr))]
        raise RuntimeError(
            f"No valid comment-fetching method found on YoutubeCommentDownloader. "
            f"Available callables: {available}"
        )

    results = []
    for c in iterator:
        text = c.get("text") or c.get("comment") or c.get("content") or c.get("contentText") or ""
        author = c.get("author") or c.get("author_name") or c.get("authorDisplayName") or ""
        like_count = c.get("votes") or c.get("likes") or c.get("likeCount") or 0
        comment_id = c.get("cid") or c.get("id") or c.get("comment_id") or ""
        published_at = c.get("time") or c.get("published") or c.get("publishedAt") or ""
        results.append({
            "comment_id": comment_id,
            "video_id": video_id_or_url,
            "author": author,
            "text": text,
            "like_count": like_count,
            "published_at": published_at
        })
        if len(results) >= max_comments:
            break
        time.sleep(sleep_between_requests)
    return results


def write_csv_local(rows: List[dict], path: str):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    keys = ["comment_id", "video_id", "author", "text", "like_count", "published_at"]
    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        for r in rows:
            writer.writerow(r)


def upload_csv_to_s3(rows: List[dict], bucket: str, key: str):
    s3 = boto3.client("s3", region_name=REGION)
    keys = ["comment_id", "video_id", "author", "text", "like_count", "published_at"]
    mem = io.StringIO()
    writer = csv.DictWriter(mem, fieldnames=keys)
    writer.writeheader()
    for r in rows:
        writer.writerow(r)
    mem.seek(0)
    s3.put_object(Bucket=bucket, Key=key, Body=mem.getvalue().encode("utf-8"))
    return f"s3://{bucket}/{key}"


class IngestResponse(BaseModel):
    video_id: str
    comments_fetched: int
    local_path: Optional[str]
    s3_path: Optional[str]


@app.get("/fetch_comments", response_model=IngestResponse)
def fetch_comments(video_url: str = Query(...), max_results: int = Query(100)):
    vid = extract_video_id(video_url)
    try:
        rows = scrape_comments(vid, max_comments=max_results)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Scrape error: {e}")

    local_path, s3_path = None, None
    if rows:
        try:
            write_csv_local(rows, LOCAL_OUT)
            local_path = LOCAL_OUT
        except Exception as e:
            local_path = None
            print(f"Warning: Failed to write CSV locally: {e}")

        if S3_BUCKET:
            ts = datetime.utcnow().strftime("%Y%m%dT%H%M%SZ")
            key = f"{S3_PREFIX}/youtube_comments_{vid}_{ts}.csv"
            try:
                s3_path = upload_csv_to_s3(rows, S3_BUCKET, key)
            except Exception as e:
                s3_path = None
                print(f"Warning: Failed to upload to S3: {e}")

    return IngestResponse(
        video_id=vid,
        comments_fetched=len(rows),
        local_path=local_path,
        s3_path=s3_path,
    )

