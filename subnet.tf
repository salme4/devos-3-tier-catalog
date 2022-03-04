resource "aws_subnet" "tier-public-subnet-1" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 1)
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch=true
  tags = {
    Name = "${var.resource_prefix}-PUB-1"
  }
}

resource "aws_subnet" "tier-public-subnet-2" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 2)
  availability_zone = length(data.aws_availability_zones.available.names)>2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch=true
  tags = {
    Name = "${var.resource_prefix}-PUB-2"
  }
}

resource "aws_subnet" "tier-web-private-subnet-1" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 3)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.resource_prefix}-WEB-PRV-1"
  }
}

resource "aws_subnet" "tier-web-private-subnet-2" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 4)
  availability_zone = length(data.aws_availability_zones.available.names)>2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.resource_prefix}-WEB-PRV-2"
  }
}

resource "aws_subnet" "tier-was-private-subnet-1" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 5)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.resource_prefix}-WAS-PRV-1"
  }
}

resource "aws_subnet" "tier-was-private-subnet-2" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 6)
  availability_zone = length(data.aws_availability_zones.available.names)>2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.resource_prefix}-WAS-PRV-2"
  }
}

resource "aws_subnet" "tier-db-subnet-1" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 7)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.resource_prefix}-DB-1"
  }
}

resource "aws_subnet" "tier-db-subnet-2" {
  vpc_id = aws_vpc.tier-vpc.id
  cidr_block = cidrsubnet(var.subnet_cidr, 4, 8)
  availability_zone = length(data.aws_availability_zones.available.names)>2 ? data.aws_availability_zones.available.names[2] : data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.resource_prefix}-DB-2"
  }
}
