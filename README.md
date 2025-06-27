# ⚠️ CloudGuardian – Real-Time AWS Threat Detection & Alerting
A production-ready, serverless security solution that detects, stores, and visualizes suspicious AWS activities in real-time – powered by Lambda, EventBridge, DynamoDB, and React – fully automated with Terraform and CI/CD via CircleCI.

![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Frontend](https://img.shields.io/badge/frontend-React-lightblue?logo=react)
![Infrastructure](https://img.shields.io/badge/infrastructure-Terraform-blueviolet?logo=terraform)
![Deployment](https://img.shields.io/badge/deployment-CircleCI%20%7C%20S3%20%2B%20API%20Gateway-green?logo=circleci)

![AWS Lambda](https://img.shields.io/badge/AWS%20Service-Lambda-orange?logo=aws-lambda)
![AWS CloudTrail](https://img.shields.io/badge/AWS%20Service-CloudTrail-green?logo=amazon-aws)
![AWS EventBridge](https://img.shields.io/badge/AWS%20Service-EventBridge-purple?logo=amazon-aws)
![AWS DynamoDB](https://img.shields.io/badge/AWS%20Service-DynamoDB-blue?logo=amazon-dynamodb)
![AWS SNS](https://img.shields.io/badge/AWS%20Service-SNS-yellow?logo=amazon-aws)
![Amazon API Gateway](https://img.shields.io/badge/AWS%20Service-API%20Gateway-red?logo=amazon-api-gateway)
![Amazon S3](https://img.shields.io/badge/AWS%20Service-S3-orange?logo=amazon-s3)


## 🚀 Key Features

✅ Real-time threat detection using AWS CloudTrail and EventBridge (e.g., root logins, EC2 stops, IAM changes)
✅ Serverless processing with AWS Lambda (Python) for event handling and threat classification
✅ Persistent storage of alerts in DynamoDB with structured records (timestamp, user, severity, message)
✅ Immediate alert notifications via Amazon SNS (email/SMS)
✅ RESTful API using Amazon API Gateway to securely fetch threat alerts from DynamoDB
✅ Frontend Dashboard built with React + Material UI for real-time alert visualization
✅ End-to-end automation using Infrastructure as Code (Terraform)
✅ CI/CD Pipeline with CircleCI to automate Lambda/API/frontend deployments
---

## 🧱 Architecture Overview
<p align="center">
  <img src="https://github.com/user-attachments/assets/d926b019-b659-46ec-9e64-621114ce79ff" width="600"/>
</p>
