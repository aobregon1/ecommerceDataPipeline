from datetime import datetime
from pathlib import Path
from airflow import DAG
from airflow.operators.bash import BashOperator
from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping
from cosmos.config import ExecutionConfig, ExecutionMode
from datetime import datetime, timedelta

# 1. Define Paths - Using /usr/local/airflow to match Astro's internal structure
INGEST_SCRIPT_PATH = "/usr/local/airflow/include/ingestion/ingest.py"
DBT_PROJECT_PATH = Path("/usr/local/airflow/dbt")

with DAG(
    dag_id="ecom_full_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule="@daily",
    catchup=False,
) as dag:

    # TASK 1: Raw Ingestion
    # Run the Python script to pull data from sources and PUT it into Snowflake stages
    ingest_raw_data = BashOperator(
        task_id="ingest_raw_data",
        bash_command=f"python {INGEST_SCRIPT_PATH}",
    )

    # TASK 2: dbt Transformation Layer (Cosmos)
    # Dynamically create Airflow tasks for every dbt model
    run_dbt_project = DbtTaskGroup(
        group_id="transform_data",
        project_config=ProjectConfig(DBT_PROJECT_PATH),
        operator_args={"install_deps": True}, # Ensures dbt-utils/packages are current
        default_args={
            "retries": 2,                  # Try again up to 2 times
            "retry_delay": timedelta(seconds=15), # Wait 15s before retrying
        },
        execution_config=ExecutionConfig(
            execution_mode=ExecutionMode.LOCAL,
        ),
        
        profile_config=ProfileConfig(
            profile_name="default",
            target_name="dev",
            profile_mapping=SnowflakeUserPasswordProfileMapping(
                conn_id="SnowflakeConn",
                profile_args={
                    "database": "ECOMMERCE_DATA_PIPELINE", 
                    "schema": "MART"
                },
            ),
        ),
    )

    # Dependency Flow: Ingest raw data first, then run transformations
    ingest_raw_data >> run_dbt_project