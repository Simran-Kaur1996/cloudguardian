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

✅ **Real-time threat detection** using AWS CloudTrail + EventBridge (e.g., root logins, EC2 stops, IAM changes)  
✅ **Event-driven Lambda (Python)** for serverless threat processing & classification  
✅ **Secure alert storage** in DynamoDB (timestamp, severity, user, event type)  
✅ **Instant alerts** via Amazon SNS (Email/SMS notifications)  
✅ **REST API** built with Amazon API Gateway for secure alert retrieval  
✅ **Frontend Dashboard** with React + Material UI for live threat monitoring  
✅ **Infrastructure as Code (IaC)** with Terraform for fully automated deployment  
✅ **CI/CD pipeline** using CircleCI to auto-deploy Lambda, API, and Frontend  
---

## 🧱 Architecture Overview
<p align="center">
  <img src="https://github.com/user-attachments/assets/a79bcbaa-f9ea-4f76-815a-f5b1de0faf61" width="600"/>
</p>

