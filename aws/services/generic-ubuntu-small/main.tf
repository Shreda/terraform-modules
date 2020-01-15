resource "aws_instance" "generic-ubuntu-small" {
  ami = "ami-00a54827eb7ffcd3c"
  instance_type = "t2.small"
}

resource "aws_key_pair" "ec2key" {
  public_key = var.public_key
  key_name = var.key_name
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Generic SSH security group"
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

