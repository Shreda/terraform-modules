resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

module "sg" {
  source = "github.com/danielmoore-info/terraform-modules//aws/security-groups/minecraft"
  vpc_id = aws_default_vpc.default.id
}

module "server" {
  source          = "github.com/danielmoore-info/terraform-modules//aws/ec2/generic-ubuntu"
  public_key      = var.public_key
  security_groups = [
    module.sg.sg_id 
  ]
  name            = var.name
  instance_type   = var.instance_type
}
