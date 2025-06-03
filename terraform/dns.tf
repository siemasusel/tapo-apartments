# --- Route 53 Hosted Zone ---
# This resource creates the DNS hosted zone for your domain.
# Once applied, you will need to update your domain's nameservers
# at your domain registrar (OVHcloud) to the NS records provided by this resource.
resource "aws_route53_zone" "primary" {
  # The root domain is the first element in the custom_domain_name list
  # e.g., "tapoapartamenty.pl"
  name = var.custom_domain_name[0]

  tags = {
    Name        = "${var.project_name}-route53-zone"
    Project     = var.project_name
    Environment = "production"
  }
}

# --- Route 53 Records for Web Traffic (Pointing to CloudFront) ---

# A record for the naked domain (e.g., tapoapartamenty.pl)
# This uses an ALIAS record to point to your CloudFront distribution,
# handling both IPv4 and IPv6 without hardcoding IPs.
resource "aws_route53_record" "naked_domain_alias" {
  # This record will be created if custom_domain_name has at least one element
  count   = length(var.custom_domain_name) > 0 ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.custom_domain_name[0] # e.g., "tapoapartamenty.pl"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# A record for the www subdomain (e.g., www.tapoapartamenty.pl)
# This also uses an ALIAS record to point to your CloudFront distribution.
resource "aws_route53_record" "www_domain_alias" {
  # This record will be created if custom_domain_name has at least two elements
  count   = length(var.custom_domain_name) > 1 ? 1 : 0
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.custom_domain_name[1] # e.g., "www.tapoapartamenty.pl"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# --- Route 53 Records for Mail and Other Services (Copied from OVHcloud) ---

# MX Records (Mail Exchanger) - for OVHcloud mail
resource "aws_route53_record" "mx_records" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.custom_domain_name[0] # Root domain for MX records
  type    = "MX"
  ttl     = 3600 # Keep the same TTL as in OVHcloud DNS

  records = [
    "1 mx0.mail.ovh.net.",
    "5 mx1.mail.ovh.net.",
    "50 mx2.mail.ovh.net.",
    "100 mx3.mail.ovh.net."
  ]
}

# SPF TXT Record
resource "aws_route53_record" "spf_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.custom_domain_name[0] # Root domain for SPF
  type    = "TXT"
  ttl     = 60 # Keep the same TTL

  records = ["v=spf1 include:mx.ovh.com ~all"]
}

# DKIM CNAME Records
resource "aws_route53_record" "dkim_selector_1" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "ovhmo-selector-1._domainkey.${var.custom_domain_name[0]}" # Full subdomain name
  type    = "CNAME"
  ttl     = 3600 # Standard CNAME TTL

  records = ["ovhmo-selector-1._domainkey.4060437.hk.dkim.mail.ovh.net."]
}

resource "aws_route53_record" "dkim_selector_2" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "ovhmo-selector-2._domainkey.${var.custom_domain_name[0]}" # Full subdomain name
  type    = "CNAME"
  ttl     = 3600 # Standard CNAME TTL

  records = ["ovhmo-selector-2._domainkey.4060438.hk.dkim.mail.ovh.net."]
}

# FTP CNAME Record
resource "aws_route53_record" "ftp_cname" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "ftp.${var.custom_domain_name[0]}" # e.g., "ftp.tapoapartamenty.pl"
  type    = "CNAME"
  ttl     = 3600 # Standard CNAME TTL

  records = [var.custom_domain_name[0]] # Points to the naked domain
}

# --- ACM validation CNAMEs ---
# This resource will create the necessary CNAME records in Route 53
# for ACM to validate your certificate automatically.
# It iterates over the 'domain_validation_options' from your aws_acm_certificate.cert resource.
# This depends on aws_acm_certificate.cert being defined elsewhere (e.g., in acm.tf)
resource "aws_route53_record" "acm_validation_records" {
  # The for_each will correctly handle iteration.
  # If aws_acm_certificate.cert[0].domain_validation_options is an empty list,
  # for_each will result in zero instances.
  for_each = { for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => dvo }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# --- CloudFront Function for Naked Domain HTTPS Redirect ---
# This function will run on CloudFront's viewer request event
# to redirect https://tapoapartamenty.pl to https://www.tapoapartamenty.pl
resource "aws_cloudfront_function" "naked_domain_redirect" {
  # This function is only created if both naked and www domains are provided in custom_domain_name
  # and they are distinct (i.e., you intend a redirect).
  count   = length(var.custom_domain_name) > 1 && var.custom_domain_name[0] != var.custom_domain_name[1] ? 1 : 0
  name    = "${var.project_name}-naked-domain-redirect"
  runtime = "cloudfront-js-1.0"
  comment = "Redirects naked domain HTTPS to www HTTPS"
  publish = true # Set to true to publish the function

  # The JS code will be read from this file path
  code = file("${path.module}/cloudfront_naked_domain_redirect.js")
}
