import os
import logging
import subprocess
from typing import List, Dict

from google.cloud import storage
from dotenv import load_dotenv

from logger import with_logging


DBT_ARTIFACTS = [
    "run_results.json",
    "manifest.json",
    "catalog.json",
    "semantic_manifest.json",
    "sources.json",
    "index.html",
]

DEFAULT_DBT_DIR = "dbt"
DEFAULT_TARGET = "sdx"
DEFAULT_ARTIFACT_PREFIX = "latest"
DEFAULT_ARTIFACT_DIR = "dbt/target"


def run_dbt_commands(
        commands: List[str],
        target: str,
        dbt_dir: str
        ) -> List[Dict]:
    results = []
    for cmd in commands:
        full_cmd = f"{cmd} --target {target} --project-dir {dbt_dir} \
            --profiles-dir {dbt_dir}"
        logging.info(f"Running DBT command: {full_cmd}")
        result = subprocess.run(
            full_cmd.split(),
            capture_output=True,
            text=True
        )

        logging.info(result.stdout.strip())
        if result.stderr:
            logging.error(result.stderr.strip())
        if result.returncode != 0:
            logging.warning(
                f"Command `{cmd}` failed with return code "
                f"{result.returncode}")

        results.append({
            "command": cmd,
            "stdout": result.stdout,
            "stderr": result.stderr,
            "returncode": result.returncode,
        })

    return results


def upload_dbt_artifacts(
        bucket_name: str,
        prefix: str,
        artifact_dir: str = DEFAULT_ARTIFACT_DIR
        ) -> None:
    logging.info(
        f"Uploading DBT artifacts from `{artifact_dir}` to "
        f"`gs://{bucket_name}/{prefix}`")
    client = storage.Client()
    bucket = client.bucket(bucket_name)

    for artifact in DBT_ARTIFACTS:
        local_path = os.path.join(artifact_dir, artifact)
        if not os.path.exists(local_path):
            logging.warning(
                f"Artifact {artifact} not found at {local_path}, "
                "skipping.")
            continue

        blob = bucket.blob(f"{prefix}/{artifact}")
        blob.upload_from_filename(local_path)
        logging.info(f"Uploaded {artifact} to {prefix}/{artifact}")


@with_logging
def main():
    load_dotenv()

    commands = os.environ["DBT_COMMAND"].split("||")
    bucket_name = os.environ["ARTIFACT_BUCKET"]
    dbt_dir = os.environ.get("DBT_DIR", DEFAULT_DBT_DIR)
    target = os.environ.get("DBT_TARGET", DEFAULT_TARGET)
    artifact_prefix = os.environ.get(
        "ARTIFACT_PREFIX",
        DEFAULT_ARTIFACT_PREFIX)

    _ = run_dbt_commands(commands, target, dbt_dir)
    upload_dbt_artifacts(bucket_name, artifact_prefix)


if __name__ == "__main__":
    main()
