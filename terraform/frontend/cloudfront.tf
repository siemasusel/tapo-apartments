# Create the CloudFront distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for ${var.project_name}"
  default_root_object = "index.html" # Serve index.html for the root URL

  aliases = var.custom_domain_name

  origin {
    domain_name = aws_s3_bucket.site_bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.site_bucket.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  # =========================================================================
  # IMPORTANT: Add a specific cache behavior for SvelteKit's _app assets
  # This ensures correct caching for version.json and immutable assets
  # =========================================================================
  ordered_cache_behavior {
    path_pattern     = "_app/*" # Matches paths like _app/version.json, _app/immutable/...
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.site_bucket.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    # Custom Cache Policy for _app/ assets (Crucial for SvelteKit)
    # This ensures version.json has a very short TTL, while immutable assets can be cached for a long time.
    # CloudFront will honor Cache-Control headers from S3.
    # SvelteKit adapter-static puts Cache-Control: immutable,max-age=31536000 on _app/immutable/* files
    # and Cache-Control: no-cache on _app/version.json.
    min_ttl     = 0        # Minimal TTL (important for version.json)
    default_ttl = 1        # Very short default TTL, effectively "no cache" for version.json
    max_ttl     = 31536000 # Long TTL for immutable assets (1 year)
    # The combination of these min/default/max TTLs with SvelteKit's own Cache-Control headers
    # sent from S3 (which adapter-static handles) allows CloudFront to perform optimally.
  }

  # Default cache behavior (handles index.html, static assets like robots.txt, sitemap.xml, etc.)
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"] # Allow standard read methods
    cached_methods   = ["GET", "HEAD"]            # Cache GET and HEAD requests
    target_origin_id = "S3-${aws_s3_bucket.site_bucket.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600  # Cache objects for 1 hour by default (e.g., your HTML pages)
    max_ttl                = 86400 # Cache objects for up to 1 day
    compress               = true

    dynamic "function_association" {
      for_each = aws_cloudfront_function.naked_domain_redirect # This will be an empty list or a list with one item
      content {
        event_type   = "viewer-request"
        function_arn = function_association.value.arn
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.custom_domain_name == null ? true : false
    acm_certificate_arn            = var.custom_domain_name != null ? aws_acm_certificate_validation.cert_validation[0].certificate_arn : null
    ssl_support_method             = var.custom_domain_name != null ? "sni-only" : null
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  tags = {
    Name        = "${var.project_name}-cloudfront"
    Project     = var.project_name
    Environment = "production"
  }

  depends_on = [aws_s3_bucket_policy.site_bucket_policy]
}
