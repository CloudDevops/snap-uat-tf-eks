resource "aws_vpc" "uat-vpc" {
  cidr_block = "10.97.224.0/20"

  tags = {
    Name = "uat-vpc"
  }
}

