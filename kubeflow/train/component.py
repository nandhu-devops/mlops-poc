# train/component.py
import os
import boto3
import pandas as pd
import tempfile
import mlflow
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

s3 = boto3.client("s3", region_name=os.getenv("AWS_REGION", "us-east-1"))


def parse_s3_uri(s3_uri):
    """Split s3://bucket/key into (bucket, key)."""
    _, _, rest = s3_uri.partition("s3://")
    bucket, _, key = rest.partition("/")
    return bucket, key


def download_s3(s3_uri, local_path):
    bucket, key = parse_s3_uri(s3_uri)
    s3.download_file(bucket, key, local_path)


def upload_s3(local_path, s3_uri):
    bucket, key = parse_s3_uri(s3_uri)
    s3.upload_file(local_path, bucket, key)


def main():
    in_uri = os.getenv("INPUT_S3_URI") or os.getenv("INPUT_CSV")
    out_uri = os.getenv("OUTPUT_S3_URI") or os.getenv("OUTPUT_CSV")
    model_name = os.getenv("MODEL_NAME", "logistic-regression")
    mlflow_uri = os.getenv("MLFLOW_URI")
    aws_region = os.getenv("AWS_REGION", "us-east-1")

    if not in_uri or not out_uri:
        raise RuntimeError(
            f"Missing INPUT_S3_URI/INPUT_CSV or OUTPUT_S3_URI/OUTPUT_CSV. Got INPUT_S3_URI={in_uri} OUTPUT_S3_URI={out_uri}"
        )

    print(f"Training model {model_name}, logging to {mlflow_uri}")
    print(f"Downloading dataset: {in_uri}")

    tmp_in = "/tmp/train.csv"
    tmp_model = "/tmp/model.pkl"

    download_s3(in_uri, tmp_in)
    df = pd.read_csv(tmp_in)

    # dummy training example (replace with your real logic)
    if "label" not in df.columns:
        raise ValueError("Input CSV must have a 'label' column for training.")

    X = df["text"].astype(str)
    y = df["label"]

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Very simple model (replace later with BERT)
    model = LogisticRegression(max_iter=100)
    model.fit([[len(x)] for x in X_train], y_train)
    preds = model.predict([[len(x)] for x in X_test])
    acc = accuracy_score(y_test, preds)

    print(f"✅ Training complete. Accuracy = {acc:.4f}")

    if mlflow_uri:
        mlflow.set_tracking_uri(mlflow_uri)
        mlflow.set_experiment("youtube-sentiment")
        with mlflow.start_run():
            mlflow.log_param("model_name", model_name)
            mlflow.log_metric("accuracy", acc)
            mlflow.sklearn.log_model(model, "model")

    # Save metrics file to S3
    out_tmp = tempfile.NamedTemporaryFile(delete=False, suffix=".txt").name
    with open(out_tmp, "w") as f:
        f.write(f"accuracy={acc}\n")

    upload_s3(out_tmp, out_uri)
    print(f"Model metrics uploaded to: {out_uri}")


if __name__ == "__main__":
    main()

