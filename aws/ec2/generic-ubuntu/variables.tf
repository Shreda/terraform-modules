variable "instance_type" {
  type        = "string"
  description = "size of the ec2 intance"
  default     = "t2.small"
}

variable "public_key" {
  type        = "string"
  description = "Public key to install onto the instance"
}

variable "security_groups" {
  type        = list(string)
  description = "Security group to associate with the instance"
}

variable "name" {
  type        = "string"
  description = "Metadata name for the intance"
  default     = "Generic Ubuntu"
}

