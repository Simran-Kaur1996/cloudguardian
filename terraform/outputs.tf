output "sns_topic_arn" {
  value = aws_sns_topic.alert_topic.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.alerts.name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec_role.arn
}
output "cloudguardian_api_key_value" {
  value     = aws_api_gateway_api_key.cloudguardian_key.value
  sensitive = true
}
