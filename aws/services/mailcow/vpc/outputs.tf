output "vpc_id" {
  value = aws_vpc.mailcowvpc.id
}

output "subnet_id" {
  value = aws_subnet.mailcowsubnet.id
}
