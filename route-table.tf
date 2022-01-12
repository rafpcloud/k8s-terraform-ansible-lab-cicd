resource "aws_route_table" "xablau" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xablau-gw.id
  }

  route {
    cidr_block = "192.168.0.0/16"
   
  }

  tags = {
    Name = "Route Table Xablau"
  }
}

resource "aws_main_route_table_association" "xablau" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.xablau.id
}

