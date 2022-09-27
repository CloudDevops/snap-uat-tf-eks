resource "aws_route_table" "uat-private" {
  vpc_id = aws_vpc.uat-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.uat-nat.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "uat-private"
  }
}

resource "aws_route_table" "uat-public" {
  vpc_id = aws_vpc.uat-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.uat-igw.id
      nat_gateway_id             = ""
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = "uat-public"
  }
}

resource "aws_route_table_association" "uat-private-us-east-2a" {
  subnet_id      = aws_subnet.uat-private-us-east-2a.id
  route_table_id = aws_route_table.uat-private.id
}

resource "aws_route_table_association" "uat-private-us-east-2b" {
  subnet_id      = aws_subnet.uat-private-us-east-2b.id
  route_table_id = aws_route_table.uat-private.id
}

resource "aws_route_table_association" "uat-public-us-east-2a" {
  subnet_id      = aws_subnet.uat-public-us-east-2a.id
  route_table_id = aws_route_table.uat-public.id
}

resource "aws_route_table_association" "uat-public-us-east-2b" {
  subnet_id      = aws_subnet.uat-public-us-east-2b.id
  route_table_id = aws_route_table.uat-public.id
}

