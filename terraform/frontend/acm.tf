# Request an ACM certificate for your custom domain
# This resource MUST be in us-east-1 for CloudFront
resource "aws_acm_certificate" "cert" {
  provider = aws.us_east_1

  # The primary domain is the root domain
  domain_name = var.root_domain_name

  # Subject Alternative Names for www and any other domains you want on this cert
  # (e.g., www.tapoapartamenty.pl)
  subject_alternative_names = ["www.${var.root_domain_name}"]

  validation_method = "DNS" # Crucial for automatic validation with Route 53

  lifecycle {
    create_before_destroy = true # Helps with seamless certificate renewal
  }

  tags = {
    Name        = "${var.project_name}-acm-certificate"
    Project     = var.project_name
    Environment = "production"
  }
}

# This resource waits for the ACM certificate to be validated automatically by Route 53.
# It relies on the Route 53 records created in dns.tf.
resource "aws_acm_certificate_validation" "cert_validation" {
  provider = aws.us_east_1
  count    = 1

  certificate_arn = aws_acm_certificate.cert.arn

  # Get the validation FQDNs from the Route 53 records we created specifically for ACM validation.
  # This makes the validation fully automated.
  validation_record_fqdns = [for record in aws_route53_record.acm_validation_records : record.fqdn]

  # This explicitly tells Terraform to ensure the Route 53 validation records
  # are created before attempting to validate the certificate.
  # This helps prevent timing issues during apply.
  depends_on = [
    aws_route53_record.acm_validation_records # This is the resource in dns.tf
  ]
}

# Outputting the certificate ARN for other resources that might need it
output "acm_certificate_arn_output" {
  description = "The ARN of the validated ACM certificate."
  value       = aws_acm_certificate.cert.arn
}
