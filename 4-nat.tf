
resource "aws_eip" "uat-nat" {
  vpc = true

  tags = {
    Name = "uat-nat"
  }
}

/*
resource "aws_nat_gateway" "public_gw" {
allocation_id = "eipalloc-010cae895c8bf8ccd"  
subnet_id     = "subnet-08c902058f56e68dc"

tags = {
  Name = "eksctl-development-cluster/NATGateway"
}

}

*/


resource "aws_nat_gateway" "uat-nat" {
  allocation_id = aws_eip.uat-nat.id
  subnet_id     = aws_subnet.uat-public-us-east-2a.id

  tags = {
    Name = "uat-nat"
  }

  depends_on = [aws_internet_gateway.uat-igw]
}

