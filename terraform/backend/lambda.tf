# --- Lambda Function Deployment ---

# Upload the Lambda deployment package (the generated zip file) to S3.
# This resource now implicitly depends on the 'lambda_zip' data source
# which is defined in 'build.tf'. Terraform automatically resolves dependencies
# across files in the same directory.
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.id
  # Use the MD5 hash of the zip file content in the S3 key.
  # This forces a new S3 object upload and Lambda update if the code changes.
  key    = "backend/${data.archive_file.lambda_zip.output_md5}.zip"
  source = data.archive_file.lambda_zip.output_path # Path to the generated zip file
  # The etag attribute is automatically calculated from the source file's MD5.
  # It helps Terraform detect changes in the file content.
  etag = data.archive_file.lambda_zip.output_md5

  tags = {
    Name        = "${var.project_name}-lambda-code-object"
    Project     = var.project_name
    Environment = "production"
  }
}

# The AWS Lambda function definition
resource "aws_lambda_function" "backend_api_lambda" {
  function_name = "${var.project_name}-backend-api"
  s3_bucket     = aws_s3_object.lambda_code.bucket
  s3_key        = aws_s3_object.lambda_code.key
  handler       = "bootstrap"    # Name of your compiled Go binary (must match -o flag in go build)
  runtime       = "provided.al2" # Recommended runtime for Go
  role          = aws_iam_role.lambda_execution_role.arn
  timeout       = 30  # seconds
  memory_size   = 128 # MB

  # Environment variables for your Go application
  environment {
    variables = {
      APP_ENV                = "prod"
      TAPO_OLA_CALENDAR_URL  = var.tapo_ola_calendar_url
      TAPO_ANIA_CALENDAR_URL = var.tapo_ania_calendar_url
      TAPO_ADMIN_API_KEY     = var.tapo_admin_api_key
    }
  }

  tags = {
    Name        = "${var.project_name}-backend-lambda"
    Project     = var.project_name
    Environment = "production"
  }
}

# CloudWatch Log Group for Lambda function logs
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.backend_api_lambda.function_name}"
  retention_in_days = 30 # Retain logs for 30 days

  tags = {
    Name        = "${var.project_name}-backend-lambda-logs"
    Project     = var.project_name
    Environment = "production"
  }
}
