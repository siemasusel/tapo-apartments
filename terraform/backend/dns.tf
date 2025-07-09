# modules/backend/dns.tf

# ACM validation records for the API Gateway certificate
resource "aws_route53_record" "api_gateway_cert_validation_records" {
  # Use for_each to create a record for each validation option returned by ACM.
  # This is crucial for handling potential multiple validation records (e.g., for SANs).
  for_each = {
    for dvo in aws_acm_certificate.api_gateway_cert.domain_validation_options : dvo.domain_name => dvo
  }

  zone_id = var.hosted_zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# Wait for the API Gateway certificate to be validated
resource "aws_acm_certificate_validation" "api_gateway_cert_validation" {
  provider                = aws # Validate the eu-central-1 cert
  certificate_arn         = aws_acm_certificate.api_gateway_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_gateway_cert_validation_records : record.fqdn]
  depends_on              = [aws_route53_record.api_gateway_cert_validation_records]
}

resource "aws_route53_record" "api_domain_alias" {
  zone_id = var.hosted_zone_id            # Your root domain's hosted zone ID
  name    = "api.${var.root_domain_name}" # The full subdomain for your API
  type    = "A"                           # Use 'A' for alias records pointing to AWS resources

  alias {
    # 'name' points to the target domain name of the API Gateway custom domain.
    # AWS provides this value once the custom domain is created.
    name = aws_apigatewayv2_domain_name.api_gateway_custom_domain.domain_name_configuration[0].target_domain_name

    # 'zone_id' is the specific Route 53 Hosted Zone ID managed by AWS
    # for the API Gateway endpoint itself, NOT your main hosted zone ID.
    zone_id = aws_apigatewayv2_domain_name.api_gateway_custom_domain.domain_name_configuration[0].hosted_zone_id

    evaluate_target_health = false
  }

  # Explicit dependency to ensure the API Gateway custom domain is ready
  # before attempting to create the DNS alias record.
  depends_on = [
    aws_apigatewayv2_domain_name.api_gateway_custom_domain
  ]
}

# Output the ARN of the validated API Gateway certificate
output "validated_api_gateway_certificate_arn" {
  value = aws_acm_certificate_validation.api_gateway_cert_validation.certificate_arn
}
