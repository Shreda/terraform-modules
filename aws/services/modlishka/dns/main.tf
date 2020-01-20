data "aws_route53_zone" "zone" {
  name = var.domain
}

resource "aws_route53_record" "dns_A_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "web.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [
    "${var.public_ip}" 
  ]
}

