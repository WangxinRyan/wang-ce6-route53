data "aws_route53_zone" "selected" {
  name         = "sctp-sandbox.com"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id                  #Zone ID of hosted zone: sctp-sandbox.com
  name    = "wang-ce6-route53"                    # Bucket name prefix, before your domain
  type    = "A"

  alias {
    name  = aws_s3_bucket_website_configuration.website.website_domain #S3 website configuration attribute: website_domain
    zone_id = aws_s3_bucket.static_bucket.hosted_zone_id # Hosted zone of the S3 bucket, Attribute:hosted_zone_id
    evaluate_target_health = true
  }
}