FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy preprocess and train components
COPY preprocess /app/preprocess
COPY train /app/train

# Default entrypoint (can be overridden in Kubeflow)
ENTRYPOINT ["python", "/app/preprocess/component.py"]

