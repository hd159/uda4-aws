from airflow.hooks.postgres_hook import PostgresHook
from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults

class DataQualityOperator(BaseOperator):

    ui_color = '#89DA59'

    @apply_defaults
    def __init__(self,
                  redshift_conn_id="",
                 tables="",
                 *args, **kwargs):

        super(DataQualityOperator, self).__init__(*args, **kwargs)
        self.redshift_conn_id = redshift_conn_id
        self.tables = tables

    def execute(self, context):
        self.log.info('execute.DataQualityOperator start')

        redshift_hook = PostgresHook(self.redshift_conn_id)
        if not self.tables:
            print(f'no tables input')
            return
            
        for table in self.tables:
            self.log.info(f"check data quality for table: {table}")
            records = redshift_hook.get_records(f"SELECT COUNT(*) FROM {table}")

            if not len(records):
                raise ValueError(
                    f"Data quality check failed. something went wrong")
            
            num_records = records[0][0]

            if num_records < 1:
                print(f'{table} no data')
                return
          
            self.log.info(
                f"check {table} passed with {num_records} records")