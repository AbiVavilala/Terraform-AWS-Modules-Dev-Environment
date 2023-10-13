
# Create AWS VPC
resource "aws_vpc" "Flask_VPC" {
  cidr_block = var.vpc_cidr
  tags = var.vpc_tags
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create public subnet
resource "aws_subnet" "Public_subnet" {
  count = length(var.pub_cidrs)
  vpc_id = aws_vpc.Flask_VPC.id
  cidr_block = var.pub_cidrs[count.index]
  availability_zone = data.aws_availability_zones.az.names[count.index]
  tags = {
    Name = "Flask-Public-${count.index + 1}"
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
  route_table_id = aws_route_table.public.id
}


# Create private subnet

resource "aws_subnet" "Private_subnet" {
  count = length(var.pri_cidrs)
  vpc_id = aws_vpc.Flask_VPC.id
  cidr_block = var.pri_cidrs[count.index]
  availability_zone = data.aws_availability_zones.az.names[count.index]
  tags = {
    Name = "Flask-Private-${count.index + 1}"
  }
  
}


# Create Security groups

resource "aws_security_group" "Flask_Securitygroup" {
  name        = "Flask_Securitygroup"
  description = "Flask security group"
  vpc_id      = aws_vpc.Flask_VPC.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Flask_project_SG"
  }
}
