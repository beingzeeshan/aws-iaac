import boto3
s3_client = boto3.client('s3')

response = s3_client.delete_object(
    Bucket='zeeshan1233212323',
    Key='listS3Bucket.py',
)