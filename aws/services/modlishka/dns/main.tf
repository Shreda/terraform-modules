data "aws_route53_zone" "mailcowzonepublic" {
  name = var.domain
}

resource "aws_route53_record" "mailcowdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = "web.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [
    "${var.public_ip}" 
  ]
}

