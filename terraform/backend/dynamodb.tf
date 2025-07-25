resource "aws_dynamodb_table" "apartments_data" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "PK"
  range_key = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-${var.dynamodb_table_name}"
    Project     = var.project_name
    Environment = "production"
  }
}
