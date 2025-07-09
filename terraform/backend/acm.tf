resource "aws_acm_certificate" "api_gateway_cert" {
  provider          = aws                           # This will use the default provider (eu-central-1)
  domain_name       = "api.${var.root_domain_name}" # The subdomain for your API
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.project_name}-backend-api-gateway-cert"
    Project     = var.project_name
    Environment = "production"
  }
}

# Outputs for DNS validation (used by backend/dns.tf)
output "domain_validation_options" {
  value = aws_acm_certificate.api_gateway_cert.domain_validation_options
}

output "certificate_arn" {
  value = aws_acm_certificate.api_gateway_cert.arn
}
