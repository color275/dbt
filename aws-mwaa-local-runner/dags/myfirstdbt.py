import os
from datetime import datetime
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
# from cosmos.profiles import PostgresUserPasswordProfileMapping
# from cosmos.profiles import RedshiftUserPasswordProfileMapping
from cosmos.profiles import PostgresUserPasswordProfileMapping
from cosmos.constants import ExecutionMode

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=PostgresUserPasswordProfileMapping(
        conn_id="postgres_dbt",
        profile_args={"schema": "ly2_stg"},
    )
)

execution_config = ExecutionConfig(
    dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",
)

my_cosmos_dag = DbtDag(
    project_config=ProjectConfig(
        dbt_project_path="/usr/local/airflow/dags/dbt/myfirstdbt",
    ),
    profile_config=profile_config,
    execution_config=execution_config,
    # normal dag parameters
    schedule_interval="@hourly",
    start_date=datetime(2023, 1, 1),
    catchup=False,
    dag_id="myfirstdbt",
    default_args={"retries": 0},
)