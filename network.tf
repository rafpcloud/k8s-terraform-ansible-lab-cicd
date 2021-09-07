
data "aws_availability_zones" "azs" {
  state = "available"
}


locals {
  az_names = data.aws_availability_zones.azs.names
}

resource "aws_vpc" "main" {

cidr_block = var.vpc_cidr 

}


resource "aws_subnet" "public" {
  for_each                = { for index, az_name in local.az_names : index => az_name }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, each.key + 1)
  availability_zone       = local.az_names[each.key]
  map_public_ip_on_launch = true
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
