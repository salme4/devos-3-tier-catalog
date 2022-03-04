resource "aws_db_instance" "tier-db-instance" {
  count = var.create_db ? 1 : 0

  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  multi_az               = true
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
}

resource "aws_db_subnet_group" "default" {
  name       = "${lower(var.resource_prefix)}-db-subnet-group"
  subnet_ids = [aws_subnet.tier-db-subnet-1.id, aws_subnet.tier-db-subnet-2.id]

  tags = {
    Name = "${var.resource_prefix}-RDS-SUBNET-GROUP"
  }
}
