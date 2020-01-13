output "ec2_public_ip" {
  value = aws_instance.generic-ubuntu-small.public_ip
  description = "ec2 instance public IP"
}
