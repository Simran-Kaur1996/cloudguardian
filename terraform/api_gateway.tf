# 📘 1. Create REST API
resource "aws_api_gateway_rest_api" "cloudguardian_api" {
  name        = "CloudGuardianAPI"
  description = "API for fetching cloud threat alerts"
}

# 🔗 2. Create /alerts resource
resource "aws_api_gateway_resource" "alerts" {
  rest_api_id = aws_api_gateway_rest_api.cloudguardian_api.id
  parent_id   = aws_api_gateway_rest_api.cloudguardian_api.root_resource_id
  path_part   = "alerts"
}

# 🟩 3. Add GET method for /alerts
resource "aws_api_gateway_method" "get_alerts" {
  rest_api_id       = aws_api_gateway_rest_api.cloudguardian_api.id
  resource_id       = aws_api_gateway_resource.alerts.id
  http_method       = "GET"
  authorization     = "NONE"
  api_key_required  = true
}

# 🔁 4. Lambda integration
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.cloudguardian_api.id
  resource_id             = aws_api_gateway_resource.alerts.id
  http_method             = aws_api_gateway_method.get_alerts.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.detect_threat.invoke_arn 
}

# 🛡️ 5. Allow API Gateway to invoke Lambda
resource "aws_lambda_permission" "apigw_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.detect_threat.function_name
  # Use the ARN of the API Gateway REST API
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.cloudguardian_api.execution_arn}/*/*"
}

# 🚀 6. Deploy the API
resource "aws_api_gateway_deployment" "api_deploy" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.cloudguardian_api.id
}

# 🏷️ 7. Create the "prod" stage
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.cloudguardian_api.id
  stage_name    = "prod"
}

# 🔐 8. Create API key
resource "aws_api_gateway_api_key" "cloudguardian_key" {
  name    = "CloudGuardianAPIKey"
  enabled = true
}

# 📊 9. Create usage plan and attach stage
resource "aws_api_gateway_usage_plan" "cloudguardian_usage_plan" {
  name = "CloudGuardianUsagePlan"

  api_stages {
    api_id = aws_api_gateway_rest_api.cloudguardian_api.id
    stage  = aws_api_gateway_stage.prod.stage_name
  }
}

# 🔐 10. Attach API key to usage plan
resource "aws_api_gateway_usage_plan_key" "cloudguardian_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.cloudguardian_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.cloudguardian_usage_plan.id
}
