# ----------------------------
# 🌍 Provider Configuration
# ----------------------------
provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

# ----------------------------
# 📦 Random suffix for S3 Bucket
# ----------------------------
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# ----------------------------
# 📁 S3 Bucket for CloudTrail logs
# ----------------------------
resource "aws_s3_bucket" "trail_bucket" {
  bucket        = "cloudguardian-trail-logs-${random_id.bucket_suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "trail_policy" {
  bucket = aws_s3_bucket.trail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:GetBucketAcl",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.trail_bucket.id}"
      },
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.trail_bucket.id}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# ----------------------------
# 🔍 CloudTrail
# ----------------------------
resource "aws_cloudtrail" "cloudguardian_trail" {
  name                          = "cloudguardian-trail"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

# ----------------------------
# 🗂️ DynamoDB Table
# ----------------------------
resource "aws_dynamodb_table" "alerts" {
  name         = "cloudguardian_alerts"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "event_id"

  attribute {
    name = "event_id"
    type = "S"
  }
}

# ----------------------------
# 📣 SNS Topic
# ----------------------------
resource "aws_sns_topic" "alert_topic" {
  name = "cloudguardian_alerts"
}

# ----------------------------
# 🎯 EventBridge Rule
# ----------------------------
resource "aws_cloudwatch_event_rule" "suspicious_activity" {
  name        = "detect-suspicious-activity"
  description = "Triggers Lambda for suspicious events"

  event_pattern = jsonencode({
    source: ["aws.signin"],
    "detail-type": ["AWS Console Sign In via CloudTrail"],
    detail: {
      userIdentity: {
        type: ["Root"]
      }
    }
  })
}

# ----------------------------
# 🔐 IAM Role for Lambda
# ----------------------------
resource "aws_iam_role" "lambda_exec_role" {
  name = "cloudguardian_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "lambda.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# ----------------------------
# IAM Policy
# ----------------------------
resource "aws_iam_policy" "lambda_policy" {
  name = "cloudguardian_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "sns:Publish"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# ----------------------------
# 🧠 Lambda Function: detect_threat
# ----------------------------
resource "aws_lambda_function" "detect_threat" {
  function_name = "cloudguardian_detect_threat"
  handler       = "detect_threat.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = "${path.module}/../backend/lambda/detect_threat.zip"
  source_code_hash = filebase64sha256("${path.module}/../backend/lambda/detect_threat.zip")
  timeout          = 10

  environment {
    variables = {
      TABLE_NAME    = aws_dynamodb_table.alerts.name
      SNS_TOPIC_ARN = aws_sns_topic.alert_topic.arn
    }
  }
}

# ----------------------------
# 🔁 EventBridge Target
# ----------------------------
resource "aws_cloudwatch_event_target" "send_to_lambda" {
  rule      = aws_cloudwatch_event_rule.suspicious_activity.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.detect_threat.arn
}

# ----------------------------
# ✅ Lambda Permission
# ----------------------------
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.detect_threat.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.suspicious_activity.arn
}

# ----------------------------
# ✅ Alert-only Lambda (SNS testing)
# ----------------------------
resource "aws_lambda_function" "cloudguardian_lambda" {
  function_name = "cloudguardian_alert_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  runtime       = "python3.12"
  handler       = "alerts.lambda_handler"
  filename      = "${path.module}/../backend/lambda/alerts.zip"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.alert_topic.arn
    }
  }
}
