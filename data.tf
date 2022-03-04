data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon-linux2" {
  most_recent = true
  owners = ["137112412989"] //Amazon Linux 2 AMI Owner ID

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ami" "amazon-common-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
}

/*data "aws_ami" "nginx-web" {
  most_recent = true
  owners = ["731727215156"]

  filter {
    name = "name"
    values = ["*WEB*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}*/

/*data "aws_ami" "tomcat-was" {
  most_recent = true
  owners = ["731727215156"]

  filter {
    name = "name"
    values = ["WAS-AMI2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}*/
