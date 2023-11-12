import pendulum
from datetime import timedelta

from airflow.decorators import dag, task
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.postgres_operator import PostgresOperator
import os
from airflow.providers.postgres.hooks.postgres import PostgresHook

default_args = {
    'owner': 'hd159',
    'start_date': pendulum.now(),
    'depends_on_past': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'catchup': False,
    'email_on_retry': False
}


@dag(
    default_args=default_args,
    description='Create tables in Redshift with Airflow',
    schedule_interval='0 * * * *'
)
def create_tables():
    start_operator = DummyOperator(task_id='Begin_execution')

    current_directory = os.path.dirname(os.path.abspath(__file__))


    @task
    def create_redshift_tables(**kwargs):
        postgres_hook = PostgresHook('redshift')
        sql_file_path = os.path.join(current_directory, "create_tables.sql")
        with open(sql_file_path, 'r') as file:
            sql_query = file.read()

        postgres_hook.run(sql_query)

    create_redshift_tables = create_redshift_tables()
    end_operator = DummyOperator(task_id='Stop_execution')

    start_operator >> create_redshift_tables >> end_operator


create_tables_dag = create_tables()
