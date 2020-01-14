resource "aws_vpc" "mailcowvpc" {
  cidr_block            = "10.10.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "mailcowvpc"
  }
}

// Create subnet within the VPC
resource "aws_subnet" "mailcowsubnet" {
  vpc_id            = "${aws_vpc.mailcowvpc.id}"
  cidr_block        = "10.10.10.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "mailcowsubnet"
  }
}
resource "aws_internet_gateway" "mailcowvpcig" {
  vpc_id = "${aws_vpc.mailcowvpc.id}"

  tags = {
    Name = "mailcowvpcig"
  }
}

resource "aws_route_table" "mailcowvpcrt" {
    vpc_id = "${aws_vpc.mailcowvpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.mailcowvpcig.id}"
    }

    tags = {
        Name = "mailcowvpcrt"
    }
}

resource "aws_route_table_association" "sdvpcrtas" {
  subnet_id       = "${aws_subnet.mailcowsubnet.id}"
  route_table_id  = "${aws_route_table.mailcowvpcrt.id}"
}

