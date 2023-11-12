
# setup
1. Create an IAM User
   Permissions - attach exiting policies:

   -  Administrator Access
   -  AmazonRedshiftFullAccess
   -  AmazonS3Full Access
2. Create Security Group
   create a `redshift_security_group`

3. Create a Redshift Cluster
4. Create a S3
5. Copy data
* aws s3 cp s3://udacity-dend/song_data/A/ s3://udapj4/song_data --recursive
  * ws s3 cp s3://udacity-dend/log_data s3://udapj4/log_data --recursive
  * upload log.json to s3.


## Project Template
1. setup Airflow
   - run /opt/airflow/start-services.sh
   - run /opt/airflow/start.sh
   - run airflow users create --email student@example.com --firstname aStudent --lastname aStudent --password admin --role Admin --username admin
   - open Airflow webapp => create redshift, and aws_credentials connection
   - run airflow scheduler
2. run create_tables dag to create table in the redshift
3. run Run finaly_project dag to run the ETL data pipeline

