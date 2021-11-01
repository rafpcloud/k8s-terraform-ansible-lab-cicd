resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.xablau.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.xablau.id
  }

  tags = {
    Name = "Route Table Xablau"
  }
}
resource "aws_route_table_association" "web-rt-association" {
  subnet_id      = aws_subnet.web1.id
  route_table_id = aws_route_table.web-rt.id

}


 