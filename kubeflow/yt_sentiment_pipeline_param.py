# yt_sentiment_pipeline_param.py
from kfp import dsl
from kfp.dsl import component

# ECR image that contains /app/preprocess/component.py and /app/train/component.py
IMAGE = "118730128420.dkr.ecr.us-east-1.amazonaws.com/yt-kfp-component:latest"

# --- Preprocessing component (returns the output s3 uri) ---
@component(base_image=IMAGE)
def preprocess(input_s3_uri: str, output_s3_uri: str, aws_region: str) -> str:
    """Preprocess YouTube comments and upload cleaned data to S3.
       Returns: output_s3_uri (so downstream components can consume it)
    """
    import os, subprocess
    os.environ["INPUT_S3_URI"] = input_s3_uri
    os.environ["OUTPUT_S3_URI"] = output_s3_uri
    os.environ["AWS_REGION"] = aws_region
    print(f"Preprocessing from {input_s3_uri} → {output_s3_uri}")
    subprocess.run(["python", "/app/preprocess/component.py"], check=True)
    # Return the output path so KFP treats it as a component output
    return output_s3_uri


# --- Training component (now accepts input_s3_uri) ---
@component(base_image=IMAGE)
def train(input_s3_uri: str, output_s3_uri: str, mlflow_uri: str, s3_bucket: str, model_name: str, aws_region: str):
    """Train sentiment model and log results to MLflow."""
    import os, subprocess
    os.environ["INPUT_S3_URI"] = input_s3_uri
    os.environ["OUTPUT_S3_URI"] = output_s3_uri
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
    MLFLOW_URI: str = "http://localhost:5000",
    S3_BUCKET: str = "mlops-yt-artifacts-nandak-1760367211",
    AWS_REGION: str = "us-east-1",
    MODEL_NAME: str = "distilbert-base-uncased"
):
    # ✅ Safely define derived training output path (avoid .replace() on PipelineParam)
    TRAIN_OUTPUT_S3_URI = "s3://mlops-yt-artifacts-nandak-1760367211/datasets/train_metrics.txt"

    # Step 1: Preprocessing (produces cleaned CSV path as output)
    pre = preprocess(
        input_s3_uri=INPUT_S3_URI,
        output_s3_uri=OUTPUT_S3_URI,
        aws_region=AWS_REGION
    )

    # Step 2: Training — input_s3_uri is the preprocess output
    tr = train(
        input_s3_uri=pre.output,  # ✅ Correct single-output reference
        output_s3_uri=TRAIN_OUTPUT_S3_URI,
        mlflow_uri=MLFLOW_URI,
        s3_bucket=S3_BUCKET,
        model_name=MODEL_NAME,
        aws_region=AWS_REGION
    )

    # Run training on node-large
    tr.add_node_selector_constraint("eks.amazonaws.com/nodegroup", "training-node")
    tr.after(pre)
