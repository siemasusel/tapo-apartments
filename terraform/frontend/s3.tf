# Create the S3 bucket to store the static website files
resource "aws_s3_bucket" "site_bucket" {
  # Bucket names must be globally unique
  bucket = "${var.project_name}-static-site-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-site-bucket"
    Project     = var.project_name
    Environment = "production"
  }
}

# Generate a random suffix to help ensure bucket name uniqueness
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Block all public access to the S3 bucket
# Access will only be allowed via CloudFront OAI
resource "aws_s3_bucket_public_access_block" "site_bucket_pab" {
  bucket = aws_s3_bucket.site_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Legacy OAI kept as an unmanaged compatibility placeholder during migration.
# It is no longer referenced by CloudFront, but keeping the Terraform resource
# avoids delete-time conflicts while CloudFront fully detaches from it.
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.project_name}"
}

# Define the S3 bucket policy to allow read access from the CloudFront distribution via OAC
data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site_bucket.arn}/*"] # Allow access to all objects in the bucket

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

# Apply the bucket policy
resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
