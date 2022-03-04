resource "aws_lb" "web-alb" {
  name = "${var.resource_prefix}-WEB-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web-alb-sg.id]
  subnets = [aws_subnet.tier-public-subnet-1.id, aws_subnet.tier-public-subnet-2.id]
}

resource "aws_lb_target_group" "web-alb-target-group" {
  name = "${var.resource_prefix}-WEB-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.tier-vpc.id
}

resource "aws_lb_listener" "web-alb-listener" {
  load_balancer_arn = aws_lb.web-alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web-alb-target-group.arn
  }
}

resource "aws_lb" "was-alb" {
  name = "${var.resource_prefix}-WAS-ALB"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.was-alb-sg.id]
  subnets = [aws_subnet.tier-was-private-subnet-1.id, aws_subnet.tier-was-private-subnet-2.id]
}

resource "aws_lb_target_group" "was-alb-target-group" {
  name = "${var.resource_prefix}-WAS-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.tier-vpc.id
}

resource "aws_lb_listener" "was-alb-listener" {
  load_balancer_arn = aws_lb.was-alb.arn
  port = 8080
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.was-alb-target-group.arn
  }
}
