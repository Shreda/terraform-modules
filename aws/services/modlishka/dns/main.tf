data "aws_route53_zone" "zone" {
  name = var.domain
}

resource "aws_route53_record" "dns_A_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.domain}"
  type    = "A"
  ttl     = 300
  records = [
    "${var.public_ip}" 
  ]
}

resource "aws_route53_record" "dns_CNAME_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "*.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [
    "web.${var.domain}" 
  ]
}
