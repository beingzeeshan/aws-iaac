import boto3
s3_start=boto3.client('s3')
response=s3_start.create_bucket(
    ACL='private',
    Bucket='newone23423234',
    CreateBucketConfiguration={
        'LocationConstraint': 'ap-south-1'
    }
)