// Grab hosted zone info
module "vpc" {
  source = "./vpc"
}

module "mailcowservice" {
  source = "./services/mailserver"
  public_key = var.public_key
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}

module "mailcowdns" {
  source = "./dns"
  domain = var.domain
  public_ip = module.mailcowservice.public_ip
}
