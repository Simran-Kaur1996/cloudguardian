import boto3
import os

sns = boto3.client('sns')
TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")

def lambda_handler(event, context):
    message = "🚨 CloudGuardian Alert: Suspicious activity detected!"
    subject = "CloudGuardian Alert"

    response = sns.publish(
        TopicArn=TOPIC_ARN,
        Message=message,
        Subject=subject
    )

    return {
        'statusCode': 200,
        'body': 'SNS alert sent',
        'messageId': response['MessageId']
    }
