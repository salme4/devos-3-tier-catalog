resource "aws_eip" "tier_eip" {
  vpc = true
  tags = {
    Name = "${var.resource_prefix}-EIP"
  }
}

resource "aws_nat_gateway" "tier-nat" {
  allocation_id = aws_eip.tier_eip.id
  subnet_id = aws_subnet.tier-public-subnet-1.id
  tags = {
    Name = "${var.resource_prefix}-Nat-Gateway"
  }
}
