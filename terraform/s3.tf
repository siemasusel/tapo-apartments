# Create a CloudFront Origin Access Identity (OAI)
# This allows CloudFront to securely access the S3 bucket content
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.project_name}"
}

# Create the S3 bucket to store the static website files
resource "aws_s3_bucket" "site_bucket" {
  # Bucket names must be globally unique
  bucket = "${var.project_name}-static-site-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "${var.project_name}-site-bucket"
    Project     = var.project_name
    Environment = "production" # Or staging, development, etc.
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

# Define the S3 bucket policy to allow read access from the CloudFront OAI
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site_bucket.arn}/*"] # Allow access to all objects in the bucket

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

# Apply the bucket policy
resource "aws_s3_bucket_policy" "site_bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

# Configure S3 bucket for static website hosting (optional but good practice)
# This is mainly a fallback and helps with potential direct S3 access configurations if needed later.
# CloudFront will be the primary access point.
# resource "aws_s3_bucket_website_configuration" "site_config" {
#   bucket = aws_s3_bucket.site_bucket.id
#
#   index_document {
#     suffix = "index.html"
#   }
#
#   error_document {
#     key = "index.html" # Redirect errors to index.html for SvelteKit routing
#   }
# }

