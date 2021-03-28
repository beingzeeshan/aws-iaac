import boto3
from botocore.exceptions import ClientError
import sys
try:
    iam_client = boto3.client('iam')
    f = open('newuser.txt','r')
    r = f.read().split('\n')
    for t in r:
        first_field = t.split(',')[0]
        second_field = t.split(',')[1]
        createuser = iam_client.create_user(
            UserName=first_field,
            PermissionsBoundary=second_field,
            Tags=[
                {
                    'Key': 'User',
                    'Value': 'Policy'
                },
            ]
        )
except ClientError as e:
    if e.response['Error']['Code'] == 'EntityAlreadyExist':
        print('User {} doesnot exist'.format(first_field))
    else:
        print('Unexpected Error')

        sys.stdout = open('check.txt', 'a+')
        createAccessKey = iam_client.create_access_key(UserName=first_field)
        print(createAccessKey)
        sys.stdout.close()
        f.close()
