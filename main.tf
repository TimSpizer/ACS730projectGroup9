# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "infrastructure_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true" # gives you an internal domain name
  enable_dns_hostnames = "true" # gives you an internal host name
  instance_tenancy     = "default"
 
  tags = {
    Name = "asg-vpc"
  }
}
 
# It enables our vpc to connect to the internet
resource "aws_internet_gateway" "infrastructure_igw" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  tags = {
    Name = "asg-igw"
  }
}
 
# Create a Public Subnet Resource
resource "aws_subnet" "public_subnet" {
  count                   = length(var.vpc_public_subnets)
  vpc_id                  = aws_vpc.infrastructure_vpc.id
  cidr_block              = var.vpc_public_subnets[count.index]
  map_public_ip_on_launch = "true" // assigned a public IP address.
  availability_zone       = var.availability_zone[count.index]
  tags = {
    Name = "public-subnet-${count.index}"
  }
}
 
 #Step 6: Create a Private Subnet Resource
resource "aws_subnet" "private_subnet" {
  count             = length(var.vpc_private_subnets)
  vpc_id            = aws_vpc.infrastructure_vpc.id
  cidr_block        = var.vpc_private_subnets[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = merge (
    {
      Name = "private-subnet-${count.index}"
    } )
}

#Create a EIP For NAT Gateway
resource "aws_eip" "my_nat_eip" {
  vpc = true
  tags = merge (
    {
      Name = "my-eip"
    }
  )
}
#NAT Gateway to provide Internet access
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.infrastructure_igw]
  tags = merge (
    {
      Name = "my-eip"
    } )
}
#Route Table Resource For Private  Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = merge (
    {
      Name = "my-private-subnet-rt"
    } )
}
#Route table Association with Private Subnets
resource "aws_route_table_association" "my_private_rt_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table" "infrastructure_route_table" {
  vpc_id = aws_vpc.infrastructure_vpc.id
 
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.infrastructure_igw.id
  }
 
}
 
# attach first subnet to an internet gateway
resource "aws_route_table_association" "route-ec2-1-subnet-to-igw" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.infrastructure_route_table.id
}
 
