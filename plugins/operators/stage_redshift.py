from airflow.hooks.postgres_hook import PostgresHook
from airflow.models import BaseOperator
from airflow.utils.decorators import apply_defaults
from airflow.operators.postgres_operator import PostgresOperator
from airflow.operators.python_operator import PythonOperator
from airflow.secrets.metastore import MetastoreBackend

class StageToRedshiftOperator(BaseOperator):
    ui_color = '#358140'

    @apply_defaults
    def __init__(self,
                 redshift_conn_id="",
                 aws_credentials_id="",
                 table="",
                 s3_bucket="",
                 s3_table="",
                 log_file="",
                 *args, **kwargs):

        super(StageToRedshiftOperator, self).__init__(*args, **kwargs)
        self.table = table
        self.redshift_conn_id = redshift_conn_id
        self.s3_bucket = s3_bucket
        self.s3_table = s3_table
        self.log_file = log_file
        self.aws_credentials_id = aws_credentials_id

    def execute(self, context):
        self.log.info('execute.StageToRedshiftOperator start')

        metastoreBackend = MetastoreBackend()
        aws_connection=metastoreBackend.get_connection(self.aws_credentials_id)
        redshift_hook = PostgresHook(self.redshift_conn_id)

        self.log.info(f"execute.StageToRedshiftOperator delete data from table: {self.table}")
        redshift_hook.run("DELETE FROM {}".format(self.table))

        self.log.info(f"execute.StageToRedshiftOperator copy data from s3 to table: {self.table}")
        s3_path = "s3://{}/{}".format(self.s3_bucket, self.s3_table)
        log_file = "s3://{}/{}".format(self.s3_bucket, self.log_file) if self.log_file else 'auto'
        stmt = """
            COPY {}
            FROM '{}'
            ACCESS_KEY_ID '{}'
            SECRET_ACCESS_KEY '{}'
            FORMAT AS JSON '{}';
        """.format(
                self.table,
                s3_path,
                aws_connection.login,
                aws_connection.password,
                log_file
            )

        redshift_hook.run(stmt)

        self.log.info('execute.StageToRedshiftOperator run successfully')





