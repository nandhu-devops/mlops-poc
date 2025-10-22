# syntax=docker/dockerfile:1
FROM python:3.10-slim

LABEL maintainer="YouTube Sentiment MLOps PoC"
LABEL stage="Kubeflow Component Image"

# system deps for building packages (psycopg2 etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc git curl ca-certificates libpq-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy and install python deps
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip setuptools wheel \
 && pip install --no-cache-dir -r /app/requirements.txt

# copy components
COPY preprocess /app/preprocess
COPY train /app/train

# default entrypoint (override in pipeline)
ENTRYPOINT ["bash", "-c"]

