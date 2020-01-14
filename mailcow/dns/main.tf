data "aws_route53_zone" "mailcowzonepublic" {
  name = var.domain
}

resource "aws_route53_record" "mailcowdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = "mail.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [
    "${var.public_ip}" 
  ]
}

resource "aws_route53_record" "autodiscoverdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = "autodiscover.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [
    "mail.${var.domain}" 
  ]
}

resource "aws_route53_record" "autoconfigdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = "autoconfig.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [
    "mail.${var.domain}" 
  ]
}

resource "aws_route53_record" "mxdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = ""
  type    = "MX"
  ttl     = "600"
  records = [
    "10 mail.${var.domain}" 
  ]
}

resource "aws_route53_record" "spfdns" {
  zone_id = "${data.aws_route53_zone.mailcowzonepublic.zone_id}"
  name    = ""
  type    = "TXT"
  ttl     = 600
  records = [
    "v=spf1 mx ~all" 
  ]
}

