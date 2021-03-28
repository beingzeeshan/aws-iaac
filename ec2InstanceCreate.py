import boto3
ec2 = boto3.resource('ec2', region_name='ap-south-1')
instance = ec2.create_instances(
    ImageId='ami-0eeb03e72075b9bcc',
    InstanceType='t2.micro',
    MaxCount=1,
    MinCount=1,
    KeyName='new'
)
print(instance[0].id)