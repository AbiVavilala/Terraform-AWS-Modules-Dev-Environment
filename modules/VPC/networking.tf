
# Create AWS VPC
resource "aws_vpc" "Flask_VPC" {
  cidr_block = var.vpc_cidr
  tags = var.vpc_tags
}

# Create public subnet
resource "aws_subnet" "Public_subnet" {
  count = length(var.pub_cidrs)
  vpc_id = aws_vpc.Flask_VPC.id
  cidr_block = var.pub_cidrs[count.index]
  availability_zone = data.aws_availability_zones.az.names[count.index]
  tags = {
    Name = "Public-${count.index + 1}"
  }
  
}

# Create Internet Gateway

resource "aws_internet_gateway" "Flask_IG" {
  vpc_id = aws_vpc.Flask_VPC.id
}

# Create route table for public subnets

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Flask_VPC.id
   
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Flask_IG.id
  } 

  tags = {
    Name = "Public router"
  }

}

# associate route table with public subnet
resource "aws_route_table_association" "public_association" {
  count = length(var.pub_cidrs)
  subnet_id      = aws_subnet.Public_subnet.*.id[count.index]
  route_table_id = aws_route_table.bar.id
}