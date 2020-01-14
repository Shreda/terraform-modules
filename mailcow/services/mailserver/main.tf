resource "aws_key_pair" "ec2key" {
  public_key  = var.public_key
  key_name    = "ec2key"
}

resource "aws_security_group" "mailcowinstancesg" {
  name        = "mailcow instance security group"
  vpc_id      = "${var.vpc_id}"
  description = "Allows required inbound ports for mailcow"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 587
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 143
    to_port     = 143
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 993
    to_port     = 993
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 110
    to_port     = 110
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 995
    to_port     = 995
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4190
    to_port     = 4190
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mailcow" {
  // Ubuntu AMI
  ami             = "ami-00a54827eb7ffcd3c"
  instance_type   = "t2.medium"
  key_name        = "${aws_key_pair.ec2key.key_name}"
  subnet_id       = "${var.subnet_id}"
  security_groups = [
    "${aws_security_group.mailcowinstancesg.id}" 
  ]

  tags = {
    Name = "Mailcow"
  }
}

resource "aws_eip" "mailcowip" {
  instance                  = "${aws_instance.mailcow.id}"
  vpc                       = true
  associate_with_private_ip = "${aws_instance.mailcow.private_ip}"
}

