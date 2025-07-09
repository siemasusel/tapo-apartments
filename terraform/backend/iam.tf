# --- Lambda Execution Role and Policy ---
# IAM role that AWS Lambda will assume when executing your function.
resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.project_name}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = "production"
  }
}

# IAM policy for basic Lambda execution (logging to CloudWatch)
resource "aws_iam_policy" "lambda_logs_policy" {
  name        = "${var.project_name}-lambda-policy"
  description = "IAM policy for Lambda to write logs to CloudWatch and access DynamoDB"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/lambda/*" # Allows logging to all log groups in the region
      },
      {
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:BatchGetItem", # For reading ranges (multiple items)
          "dynamodb:Query",        # For reading ranges with conditions
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
        ]
        Effect = "Allow"
        # Now using the new variable for the DynamoDB table name pattern
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_logs_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_logs_policy.arn
}
