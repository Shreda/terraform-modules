resource "aws_key_pair" "ec2key" {
  public_key = var.public_key
}

resource "aws_instance" "ec2instance" {
  ami             = "ami-00a54827eb7ffcd3c"
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ec2key.key_name
  security_groups = var.security_groups

  tags = {
    Name = vars.name 
  }
}

