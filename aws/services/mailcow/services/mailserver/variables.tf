variable "public_key" {
  type = "string"
  description = "public key to install on instance"
}

variable "vpc_id" {
  type = "string"
  description = "VPC to use"
}

variable "subnet_id" {
  type = "string"
  description = "Subnet to deploy into"
}

variable "security_groups" {
  type = list(string)
  description = "List of security groups for the instance"
}
