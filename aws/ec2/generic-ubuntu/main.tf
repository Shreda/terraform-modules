resource "aws_key_pair" "ec2key" {
  public_key = var.public_key
}

resource "aws_instance" "ec2instance" {
  ami             = "ami-00a54827eb7ffcd3c"
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ec2key.key_name
  vpc_security_group_ids = var.security_groups

  tags = {
    Name = var.name 
  }
}

