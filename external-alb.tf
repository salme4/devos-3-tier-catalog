resource "aws_lb" "external-was-alb" {
  name = "${var.resource_prefix}-EXWAS-ALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.was-alb-sg.id]
  subnets = [aws_subnet.tier-public-subnet-1.id, aws_subnet.tier-public-subnet-2.id]
}

resource "aws_lb_target_group" "external-was-alb-target-group" {
  name = "${var.resource_prefix}-EXWAS-TG"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.tier-vpc.id
}

resource "aws_lb_listener" "external-was-alb-listener" {
  load_balancer_arn = aws_lb.external-was-alb.arn
  port = 8080
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.external-was-alb-target-group.arn
  }
}
