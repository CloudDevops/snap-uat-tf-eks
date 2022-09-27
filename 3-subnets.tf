resource "aws_subnet" "uat-private-us-east-2a" {
  vpc_id            = aws_vpc.uat-vpc.id
  cidr_block        = "10.97.224.0/22"
  availability_zone = "us-east-2a"

  tags = {
    "Name"                            = "uat-private-us-east-2a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "uat-private-us-east-2b" {
  vpc_id            = aws_vpc.uat-vpc.id
  cidr_block        = "10.97.228.0/22"
  availability_zone = "us-east-2b"

  tags = {
    "Name"                            = "uat-private-us-east-2b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "uat-public-us-east-2a" {
  vpc_id                  = aws_vpc.uat-vpc.id
  cidr_block              = "10.97.232.0/22"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "uat-public-us-east-2a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "uat-public-us-east-2b" {
  vpc_id                  = aws_vpc.uat-vpc.id
  cidr_block              = "10.97.236.0/22"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "uat-public-us-east-2b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

