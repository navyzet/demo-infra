resource "aws_vpc" "demo_stage" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  tags = {
    Name = "Demo network"
  }
}

# create the Subnet
resource "aws_subnet" "demo_subnet" {
  vpc_id                  = aws_vpc.demo_stage.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  tags = {
    Name = "Demo subnet"
  }
}

# Create the Security Group
resource "aws_security_group" "demo_security_group" {
  vpc_id      = aws_vpc.demo_stage.id
  name        = "Demo VPC Security Group"
  description = "Demo VPC Security Group"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Demo Security Group"
    Description = "Demo Security Group"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "demo_GW" {
  vpc_id = aws_vpc.demo_stage.id
  tags = {
    Name = "Demo Internet Gateway"
  }
}

# Create the Route Table
resource "aws_route_table" "demo_route_table" {
  vpc_id = aws_vpc.demo_stage.id
  tags = {
    Name = "Demo Route Table"
  }
}

# Create the Internet Access
resource "aws_route" "demo_internet_access" {
  route_table_id         = aws_route_table.demo_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.demo_GW.id
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "demo_VPC_association" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.demo_route_table.id
}
