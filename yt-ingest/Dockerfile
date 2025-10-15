# Dockerfile.debug
FROM python:3.10-slim

ENV PIP_NO_CACHE_DIR=1
ENV PIP_DEFAULT_TIMEOUT=120
ENV PIP_INDEX_URL=https://pypi.org/simple

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential gcc zlib1g-dev libpq-dev ca-certificates curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/requirements.txt .

# Upgrade pip/tools first (important)
RUN pip3 install --upgrade pip setuptools wheel

# Install each dependency separately so we can see which one fails
# Note: uvicorn[standard] needs quoting so shell doesn't expand []
RUN set -ex && \
    pip3 install --verbose fastapi || true && \
    pip3 install --verbose "uvicorn[standard]" || true && \
    pip3 install --verbose youtube-comment-downloader || true && \
    pip3 install --verbose boto3 || true

# show installed packages for sanity
RUN pip3 freeze || true

COPY app/ .

RUN mkdir -p /data

EXPOSE 8080

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]

