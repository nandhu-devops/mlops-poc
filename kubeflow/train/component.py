# preprocess/component.py
import os, pandas as pd, boto3, tempfile
s3 = boto3.client("s3", region_name=os.getenv("AWS_REGION","us-east-1"))

def download_s3(s3_uri, local_path):
    # s3_uri like s3://bucket/key
    _,_,rest = s3_uri.partition("s3://")
    bucket,_,key = rest.partition("/")
    s3.download_file(bucket, key, local_path)

def upload_s3(local_path, s3_uri):
    _,_,rest = s3_uri.partition("s3://")
    bucket,_,key = rest.partition("/")
    s3.upload_file(local_path, bucket, key)

def main():
    in_uri = os.environ["INPUT_CSV"]    # e.g. s3://.../raw.csv
    out_uri = os.environ["OUTPUT_CSV"]  # e.g. s3://.../cleaned.csv
    tmp_in = "/tmp/in.csv"
    tmp_out = "/tmp/out.csv"
    download_s3(in_uri, tmp_in)
    df = pd.read_csv(tmp_in)
    # basic cleaning
    df = df.dropna(subset=["text"]).reset_index(drop=True)
    df["text"] = df["text"].astype(str).str.replace("\n"," ")
    df.to_csv(tmp_out, index=False)
    upload_s3(tmp_out, out_uri)
    print(out_uri)

if __name__=="__main__":
    main()

