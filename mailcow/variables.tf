variable "domain" {
  type        = "string"
  description = "The domain used to set up the web server (example.com)"
}

variable "public_key" {
  type        = "string"
  description = "The public key to be installed on ec2 instances for SSH"
}

