resource "aws_key_pair" "ec2key" {
  public_key  = var.public_key
}

resource "aws_instance" "mailcow" {
  // Ubuntu AMI
  ami             = "ami-00a54827eb7ffcd3c"
  instance_type   = "t2.medium"
  key_name        = "${aws_key_pair.ec2key.key_name}"
  subnet_id       = "${var.subnet_id}"
  security_groups = var.security_groups

  tags = {
    Name = "Mailcow"
  }
}

resource "aws_eip" "mailcowip" {
  instance                  = "${aws_instance.mailcow.id}"
  vpc                       = true
  associate_with_private_ip = "${aws_instance.mailcow.private_ip}"
}

