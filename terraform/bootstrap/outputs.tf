output "terraform_state_bucket" {
  description = "S3 bucket name for Terraform remote state."
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_lock_table" {
  description = "DynamoDB table name for Terraform state locking."
  value       = aws_dynamodb_table.terraform_locks.name
}

output "terraform_state_region" {
  description = "AWS region for the Terraform remote state backend."
  value       = var.aws_region
}

output "terraform_state_key" {
  description = "Suggested state object key for the root Terraform stack."
  value       = var.state_key
}
