# Manages a Route53 Hosted Zone
resource "aws_route53_zone" "exampleDomain" {
  name = var.domainName
}

# Provides a Route53 record resource
resource "aws_route53_record" "exampleDomain-a" {
  zone_id = aws_route53_zone.exampleDomain.zone_id
  name    = var.domainName
  type    = "A"
  
  alias {
    name                   = aws_s3_bucket.example.website_endpoint
    zone_id                = aws_s3_bucket.example.hosted_zone_id
    evaluate_target_health = true
  }
}