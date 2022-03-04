resource "aws_instance" "bastion-ec2" {
  ami = data.aws_ami.amazon-linux2.id
  instance_type = var.bastion_instance_type
  associate_public_ip_address = true
  subnet_id = aws_subnet.tier-public-subnet-1.id
  key_name = var.bastion_key_pair_name
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name = "${var.resource_prefix}-Bastion"
  }
}
