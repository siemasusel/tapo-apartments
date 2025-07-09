# --- Route 53 Hosted Zone ---
# This resource creates the DNS hosted zone for your domain.
# Once applied, you will need to update your domain's nameservers
# at your domain registrar (OVHcloud) to the NS records provided by this resource.
resource "aws_route53_zone" "primary" {
  # The root domain e.g., "tapoapartamenty.pl"
  name = var.root_domain_name

  tags = {
    Name        = "${var.project_name}-route53-zone"
    Project     = var.project_name
    Environment = "production"
  }
}

# Output the hosted zone ID so other modules can use it
output "hosted_zone_id" {
  description = "The ID of the primary Route 53 hosted zone."
  value       = aws_route53_zone.primary.zone_id
}
