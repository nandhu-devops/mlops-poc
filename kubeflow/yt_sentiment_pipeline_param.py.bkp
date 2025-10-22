from kfp import dsl
from kfp.dsl import component

# 👇 Use your ECR image that includes preprocess/train code
IMAGE = "118730128420.dkr.ecr.us-east-1.amazonaws.com/yt-kfp-component:latest"

# --- Preprocessing component ---
@component(base_image=IMAGE)
def preprocess(input_s3_uri: str, output_s3_uri: str, aws_region: str):
    """Preprocess YouTube comments and upload cleaned data to S3."""
    import os, subprocess
    os.environ["INPUT_S3_URI"] = input_s3_uri
    os.environ["OUTPUT_S3_URI"] = output_s3_uri
    os.environ["AWS_REGION"] = aws_region
    print(f"Preprocessing from {input_s3_uri} → {output_s3_uri}")
    subprocess.run(["python", "/app/preprocess/component.py"], check=True)

# --- Training component ---
@component(base_image=IMAGE)
def train(mlflow_uri: str, s3_bucket: str, model_name: str, aws_region: str):
    """Train sentiment model and log results to MLflow."""
    import os, subprocess
    os.environ["MLFLOW_URI"] = mlflow_uri
    os.environ["S3_BUCKET"] = s3_bucket
    os.environ["MODEL_NAME"] = model_name
    os.environ["AWS_REGION"] = aws_region
    print(f"Training model {model_name}, logging to {mlflow_uri}")
    subprocess.run(["python", "/app/train/component.py"], check=True)

# --- Pipeline definition ---
@dsl.pipeline(
    name="yt-sentiment-pipeline-param",
    description="YouTube Sentiment Analyzer pipeline using MLflow + S3 + EKS"
)
def yt_sentiment_pipeline(
    INPUT_S3_URI: str = "s3://mlops-yt-artifacts-nandak-1760367211/datasets/raw.csv",
    OUTPUT_S3_URI: str = "s3://mlops-yt-artifacts-nandak-1760367211/datasets/cleaned.csv",
    MLFLOW_URI: str = "http://mlflow-service.mlops.svc.cluster.local:5000",
    S3_BUCKET: str = "mlops-yt-artifacts-nandak-1760367211",
    AWS_REGION: str = "us-east-1",
    MODEL_NAME: str = "distilbert-base-uncased"
):
    # Step 1: Preprocessing
    pre = preprocess(
        input_s3_uri=INPUT_S3_URI,
        output_s3_uri=OUTPUT_S3_URI,
        aws_region=AWS_REGION
    )

    # Step 2: Training (depends on preprocess)
    tr = train(
        mlflow_uri=MLFLOW_URI,
        s3_bucket=S3_BUCKET,
        model_name=MODEL_NAME,
        aws_region=AWS_REGION
    )
    # ✅ Correct usage of node selector
    tr.add_node_selector_constraint("eks.amazonaws.com/nodegroup", "node-large")
    tr.after(pre)

