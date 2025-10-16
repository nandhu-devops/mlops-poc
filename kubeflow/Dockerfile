# syntax=docker/dockerfile:1
FROM python:3.10-slim

LABEL maintainer="YouTube Sentiment MLOps PoC"
LABEL stage="Kubeflow Component Image"

# ---- System setup ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# ---- Install Python dependencies ----
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Copy component folders ----
COPY preprocess /app/preprocess
COPY train /app/train

# ---- Default command ----
# Component entrypoint (override in Kubeflow)
ENTRYPOINT ["bash", "-c"]

