resource "aws_internet_gateway" "uat-igw" {
  vpc_id = aws_vpc.uat-vpc.id

  tags = {
    Name = "uat-igw"
  }
}

