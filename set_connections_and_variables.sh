#!/bin/bash
#
# TO-DO: run the follwing command and observe the JSON output: 
# airflow connections get aws_credentials -o json 
# 
# [
#     {
#         "id": "67",
#         "conn_id": "aws_credentials",
#         "conn_type": "aws",
#         "description": "",
#         "host": "",
#         "schema": "",
#         "login": "AKIASLSKCNYSPLSFHQSL",
#         "password": "eW8BUbS/K7o4mMMRoVcYxGxLoe5KJtmGO9UElY5k",
#         "port": null,
#         "is_encrypted": "True",
#         "is_extra_encrypted": "True",
#         "extra_dejson": {},
#         "get_uri": "aws://AKIASLSKCNYSPLSFHQSL:eW8BUbS%2FK7o4mMMRoVcYxGxLoe5KJtmGO9UElY5k@"
#     }
# ]
#
# Copy the value after "get_uri":
#
# For example: aws://AKIA4QE4NTH3R7EBEANN:s73eJIJRbnqRtll0%2FYKxyVYgrDWXfoRpJCDkcG2m@
#
# TO-DO: Update the following command with the URI and un-comment it:
#
airflow connections add aws_credentials --conn-uri 'aws://AKIASLSKCNYSPLSFHQSL:eW8BUbS%2FK7o4mMMRoVcYxGxLoe5KJtmGO9UElY5k@'
#
#
# TO-DO: run the follwing command and observe the JSON output: 
# airflow connections get redshift -o json
# 
# [
#     {
#         "id": "68",
#         "conn_id": "redshift",
#         "conn_type": "redshift",
#         "description": "",
#         "host": "default-workgroup.162290363940.us-east-1.redshift-serverless.amazonaws.com",
#         "schema": "dev",
#         "login": "admin",
#         "password": "chungdd159A!",
#         "port": "5439",
#         "is_encrypted": "True",
#         "is_extra_encrypted": "True",
#         "extra_dejson": {},
#         "get_uri": "redshift://admin:chungdd159A%21@default-workgroup.162290363940.us-east-1.redshift-serverless.amazonaws.com:5439/dev"
#     }
# ]
# Copy the value after "get_uri":
#
# For example: redshift://awsuser:R3dsh1ft@default.859321506295.us-east-1.redshift-serverless.amazonaws.com:5439/dev
#
# TO-DO: Update the following command with the URI and un-comment it:
#
airflow connections add redshift --conn-uri 'redshift://admin:chungdd159A%21@default-workgroup.162290363940.us-east-1.redshift-serverless.amazonaws.com:5439/dev'
#
# TO-DO: update the following bucket name to match the name of your S3 bucket and un-comment it:
#
airflow variables set s3_bucket udapj4
#
# TO-DO: un-comment the below line:
#
airflow variables set s3_prefix data-pipelines