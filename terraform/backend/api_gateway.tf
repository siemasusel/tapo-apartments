# --- API Gateway V2 HTTP API ---

# The main API Gateway HTTP API
resource "aws_apigatewayv2_api" "backend_http_api" {
  name          = "${var.project_name}-backend-http-api"
  protocol_type = "HTTP" # Required for HTTP API

  # For Lambda integrations, you often want to enable CORS here
  # This is a basic example; adjust as needed for your frontend.
  cors_configuration {
    allow_methods = ["*"] # Adjust to specific methods like ["GET", "POST"]
    allow_headers = ["*"] # Adjust to specific headers
    allow_origins = ["*"] # VERY IMPORTANT: Change this to your frontend's domain in production!
    max_age       = 300
  }

  tags = {
    Name        = "${var.project_name}-gateway-http-api"
    Project     = var.project_name
    Environment = "production"
  }
}

# Lambda Integration for the HTTP API
resource "aws_apigatewayv2_integration" "api_lambda_integration" {
  api_id             = aws_apigatewayv2_api.backend_http_api.id
  integration_type   = "AWS_PROXY" # For Lambda proxy integration
  integration_method = "POST"      # Lambda invocation is always POST
  integration_uri    = aws_lambda_function.backend_api_lambda.invoke_arn

  # This is the crucial part for proxying the request as-is
  # For simple proxy to Lambda, this is often '2.0' to use V2 event format
  # However, for gin-lambda, setting it to '1.0' might be needed if you prefer V1 events with HTTP API
  # But if you're switching to HTTP API, it's best to use V2 event and ginadapter.NewV2()
  # For ginadapter.NewV2(), this should be "2.0"
  payload_format_version = "2.0"
}

# Define the catch-all route for the HTTP API
resource "aws_apigatewayv2_route" "api_proxy_route" {
  api_id    = aws_apigatewayv2_api.backend_http_api.id
  route_key = "ANY /{proxy+}" # Matches all HTTP methods and all paths
  target    = "integrations/${aws_apigatewayv2_integration.api_lambda_integration.id}"
}

# Deploy the HTTP API to a stage
resource "aws_apigatewayv2_stage" "api_http_stage" {
  api_id      = aws_apigatewayv2_api.backend_http_api.id
  name        = "prod" # Your stage name
  auto_deploy = true   # Automatically deploy on route/integration changes

  # Optional: Enable access logging for HTTP API
  # access_log_settings {
  #   destination_arn = aws_cloudwatch_log_group.http_api_access_logs.arn
  #   format          = jsonencode({
  #     requestId    = "$context.requestId"
  #     ip           = "$context.extendedRequestId" # HTTP API uses extendedRequestId for some fields
  #     requestTime  = "$context.requestTime"
  #     httpMethod   = "$context.httpMethod"
  #     path         = "$context.path"
  #     status       = "$context.status"
  #     protocol     = "$context.protocol"
  #     responseLength = "$context.responseLength"
  #     integrationErrorMessage = "$context.integrationErrorMessage"
  #   })
  # }

  tags = {
    Name        = "${var.project_name}-gateway-http-stage"
    Project     = var.project_name
    Environment = "production"
  }
}

# Permission for API Gateway (V2) to invoke Lambda
# The source_arn for V2 is slightly different
resource "aws_lambda_permission" "http_api_lambda_permission" {
  statement_id  = "AllowHttpAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend_api_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  # V2 execution ARN format: arn:aws:execute-api:{region}:{account-id}:{api-id}/*/*
  source_arn = "${aws_apigatewayv2_api.backend_http_api.execution_arn}/*/*"
}

# Optional: CloudWatch Log Group for HTTP API access logs (if you uncomment access_log_settings above)
# resource "aws_cloudwatch_log_group" "http_api_access_logs" {
#   name              = "/aws/http-api/${aws_apigatewayv2_api.backend_http_api.name}/access-logs"
#   retention_in_days = 7
#   tags = {
#     Name        = "${var.project_name}-http-gateway-logs"
#     Project     = var.project_name
#     Environment = "production"
#   }
# }
