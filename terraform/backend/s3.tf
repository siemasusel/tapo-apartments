resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "${lower(var.project_name)}-lambda-code-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-lambda-code-bucket"
    Project     = var.project_name
    Environment = "production"
  }
}

resource "aws_s3_bucket_versioning" "lambda_code_versioning" {
  bucket = aws_s3_bucket.lambda_code_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_code_sse" {
  bucket = aws_s3_bucket.lambda_code_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lambda_code_lifecycle" {
  bucket = aws_s3_bucket.lambda_code_bucket.id

  rule {
    id     = "expire-non-current-versions"
    status = "Enabled"

    filter {
      prefix = "" # This indicates the rule applies to all objects in the bucket
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
