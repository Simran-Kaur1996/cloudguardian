# ⚠️ CloudGuardian – Real-Time AWS Threat Detection & Alerting

> A serverless, real-time cloud threat detection system built using AWS Lambda, EventBridge, CloudTrail, DynamoDB, and SNS – fully deployed via Terraform.

![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Infrastructure](https://img.shields.io/badge/infrastructure-Terraform-blueviolet)
![AWS Lambda](https://img.shields.io/badge/AWS%20Service-Lambda-orange?logo=aws-lambda)
![AWS CloudTrail](https://img.shields.io/badge/AWS%20Service-CloudTrail-green?logo=amazon-aws)
![AWS EventBridge](https://img.shields.io/badge/AWS%20Service-EventBridge-purple?logo=amazon-aws)
![AWS DynamoDB](https://img.shields.io/badge/AWS%20Service-DynamoDB-blue?logo=amazon-dynamodb)
![AWS SNS](https://img.shields.io/badge/AWS%20Service-SNS-yellow?logo=amazon-aws)

---

## 🔐 Why CloudGuardian?

CloudGuardian is a fully automated AWS security monitoring solution that detects suspicious activity (e.g., **root logins**) in real time, stores the data in DynamoDB, and sends alert notifications via SNS

---

## 🚀 Key Features

- ✅ **Real-time root login detection** via AWS CloudTrail + EventBridge
- ✅ **Email alerting** with formatted threat details using SNS
- ✅ **Serverless Lambda functions** for automation (Python)
- ✅ **Persistent storage** of events in DynamoDB
- ✅ **Fully infrastructure-as-code** using Terraform
---

## 🧱 Architecture Overview

![image](https://github.com/user-attachments/assets/d926b019-b659-46ec-9e64-621114ce79ff)

