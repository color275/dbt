import os
from datetime import datetime
from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
# from cosmos.profiles import PostgresUserPasswordProfileMapping
from cosmos.profiles import RedshiftUserPasswordProfileMapping
from cosmos.constants import ExecutionMode

profile_config = ProfileConfig(
    profile_name="default",
    target_name="prod",
    profile_mapping=RedshiftUserPasswordProfileMapping(
        conn_id="redshift_default",
        profile_args={"schema": "prod"},
    )
)

execution_config = ExecutionConfig(
    dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",
)

my_cosmos_dag = DbtDag(
    project_config=ProjectConfig(
        dbt_project_path="/usr/local/airflow/dags/dbt/prod",
    ),
    profile_config=profile_config,
    execution_config=execution_config,
    # normal dag parameters
    schedule_interval="@hourly",
    start_date=datetime(2023, 1, 1),
    catchup=False,
    dag_id="dbt_prod",
    default_args={"retries": 1},
)