# Create the CloudFront distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for ${var.project_name}"
  default_root_object = "index.html" # Serve index.html for the root URL

  # If a custom domain is provided, use it
  aliases = var.custom_domain_name != null ? [var.custom_domain_name] : []

  # Origin configuration - pointing to the S3 bucket
  origin {
    domain_name = aws_s3_bucket.site_bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.site_bucket.id}"

    # Use the OAI to access the S3 bucket securely
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  # Default cache behavior
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"] # Allow standard read methods
    cached_methods   = ["GET", "HEAD"]            # Cache GET and HEAD requests
    target_origin_id = "S3-${aws_s3_bucket.site_bucket.id}"

    # Forward query strings, headers, and cookies as needed (adjust if necessary)
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    # Use HTTPS only for viewer connections
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600  # Cache objects for 1 hour by default
    max_ttl                = 86400 # Cache objects for up to 1 day

    # Compress objects automatically (e.g., gzip, brotli)
    compress = true
  }

  # Price class - controls the geographic scope of edge locations
  # PriceClass_100: North America & Europe
  # PriceClass_200: North America, Europe, Asia, Middle East, Africa
  # PriceClass_All: All edge locations (highest cost, best performance globally)
  price_class = "PriceClass_100" # Adjust as needed

  # Restrictions - typically not needed for public websites
  restrictions {
    geo_restriction {
      restriction_type = "none" # No geographic restrictions
    }
  }

  # Viewer certificate configuration
  viewer_certificate {
    # Use the default CloudFront certificate if no custom domain is provided
    # Otherwise, use the specified ACM certificate
    cloudfront_default_certificate = var.custom_domain_name == null ? true : false
    acm_certificate_arn            = var.custom_domain_name != null ? var.acm_certificate_arn : null
    ssl_support_method             = var.custom_domain_name != null ? "sni-only" : null # Use SNI for custom domains
    minimum_protocol_version       = "TLSv1.2_2021"                                     # Use a modern TLS version
  }

  # Custom error response for 403 and 404 errors
  # Redirects to index.html with a 200 status code to allow SvelteKit's client-side router to handle the path
  custom_error_response {
    error_caching_min_ttl = 10 # Cache the error response briefly
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

  # Wait for the S3 bucket policy to be applied before creating the distribution
  depends_on = [aws_s3_bucket_policy.site_bucket_policy]
}

