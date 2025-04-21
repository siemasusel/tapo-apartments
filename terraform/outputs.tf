# Output the name of the S3 bucket created
output "s3_bucket_name" {
  description = "The name of the S3 bucket storing the website files."
  value       = aws_s3_bucket.site_bucket.bucket
}

# Output the ID of the S3 bucket
output "s3_bucket_id" {
  description = "The ID of the S3 bucket."
  value       = aws_s3_bucket.site_bucket.id
}

# Output the domain name of the CloudFront distribution
# This is the URL you will use to access your website
output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

# Output the ID of the CloudFront distribution
output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.s3_distribution.id
}
