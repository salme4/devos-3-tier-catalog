resource "aws_internet_gateway" "tier-igw" {
  vpc_id = aws_vpc.tier-vpc.id

  tags = {
    Name = "${var.resource_prefix}-IGW"
  }
}
