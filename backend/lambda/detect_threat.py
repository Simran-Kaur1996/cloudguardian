import json
import boto3
import uuid
from datetime import datetime
import os

# Initialize AWS clients
dynamodb = boto3.resource('dynamodb')
sns = boto3.client('sns')

# Get values from environment variables
TABLE_NAME = os.environ['TABLE_NAME']
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    print("Received event:", json.dumps(event, indent=2))

    # ✅ If triggered via API Gateway (frontend fetch)
    if event.get("httpMethod") == "GET":
        table = dynamodb.Table(TABLE_NAME)
        response = table.scan(Limit=10)
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps(response.get("Items", []))
        }

    # ✅ If triggered via EventBridge (CloudTrail event)
    user_type = event.get("detail", {}).get("userIdentity", {}).get("type", "")
    if user_type == "Root":
        alert_id = str(uuid.uuid4())
        event_time = event.get("detail", {}).get("eventTime", datetime.utcnow().isoformat())

        item = {
            "event_id": alert_id,
            "event_time": event_time,
            "event_name": event["detail"].get("eventName", "Unknown"),
            "source_ip": event["detail"].get("sourceIPAddress", "Unknown"),
            "user_agent": event["detail"].get("userAgent", "Unknown"),
            "event_type": "RootLogin"
        }

        # Store in DynamoDB
        table = dynamodb.Table(TABLE_NAME)
        table.put_item(Item=item)

        # Send SNS alert
        message = f"🚨 CloudGuardian Alert: Root Login Detected\n\n{json.dumps(item, indent=2)}"
        response = sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="🚨 CloudGuardian Alert: Root Login",
            Message=message
        )

        return {
            'statusCode': 200,
            'body': 'Root login alert processed and SNS notification sent',
            'messageId': response['MessageId']
        }

    # If no root login or API call
    return {
        'statusCode': 200,
        'body': 'No root login detected or unsupported trigger source'
    }
