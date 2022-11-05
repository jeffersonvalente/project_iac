# Cria o certificado de wildcard
resource "aws_acm_certificate" "jeffersonvalente" {
  domain_name       = "*.jeffersonvalente.com.br"
  validation_method = "DNS"
}

# chama a zona hospedada
data "aws_route53_zone" "jeffersonvalente" {
  name         = "jeffersonvalente.com.br"
  private_zone = false
}

# selecting validation method
resource "aws_route53_record" "jeffersonvalente" {
  for_each = {
    for dvo in aws_acm_certificate.jeffersonvalente.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.jeffersonvalente.zone_id
}

# valida o cerficado atraves do dns
resource "aws_acm_certificate_validation" "jeffersonvalente" {
  certificate_arn         = aws_acm_certificate.jeffersonvalente.arn
  validation_record_fqdns = [for record in aws_route53_record.jeffersonvalente : record.fqdn]
}

resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.jeffersonvalente.zone_id
  name    = "tooling.jeffersonvalente.com.br"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}

# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.jeffersonvalente.zone_id
  name    = "wordpress.jeffersonvalente.com.br"
  type    = "A"

  alias {
    name                   = aws_lb.ext-alb.dns_name
    zone_id                = aws_lb.ext-alb.zone_id
    evaluate_target_health = true
  }
}