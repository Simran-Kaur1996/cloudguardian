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

CloudGuardian is a fully automated AWS security monitoring solution that detects suspicious activity (e.g., **root logins**) in real time, stores the data in DynamoDB, and sends alert notifications via SNS. Ideal for cloud engineers and DevOps professionals seeking hands-on AWS security and automation experience.

---

## 🚀 Key Features

- ✅ **Real-time root login detection** via AWS CloudTrail + EventBridge
- ✅ **Email alerting** with formatted threat details using SNS
- ✅ **Serverless Lambda functions** for automation (Python)
- ✅ **Persistent storage** of events in DynamoDB
- ✅ **Fully infrastructure-as-code** using Terraform
- ✅ **100% AWS Free Tier compatible**

---

## 🧱 Architecture Overview

```
## 🧭 Visual Architecture Diagram

![CloudGuardian Architecture](architecture/cloudguardian_architecture.png)
```

---

## 📁 Project Structure

```
cloudguardian/
├── backend/
│   └── lambda/
│       ├── alerts.py         # Test Lambda to send SNS alerts manually
│       └── detect_threat.py  # Main Lambda to detect & report root logins
├── terraform/
│   ├── main.tf               # Terraform infrastructure setup
│   ├── variables.tf          # AWS region + inputs
│   └── outputs.tf            # Outputs for resources
├── .gitignore
└── README.md
```

---

