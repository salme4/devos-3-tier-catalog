resource "aws_launch_configuration" "web-launch-configuration" {
  name   = "${var.resource_prefix}-WEB-LAUNCH-CONFIGURATION"
  image_id      = data.aws_ami.amazon-common-ami.id
  instance_type = var.web_instance_type

  key_name = var.instance_key_pair_name

  associate_public_ip_address = false
  security_groups = [aws_security_group.web-lc-sg.id]

  user_data = base64encode(templatefile("${path.module}/app/run_web.tpl",
  {
    apache_server_name=aws_lb.was-alb.dns_name
    apache_com_error="apache_error"
    apache_access="apache_access"
    web_alb_dns=aws_lb.was-alb.dns_name
    web_alb_port="8080"
    web_app=""
    was_app=""
  }))
}

resource "aws_autoscaling_group" "web-autoscaling-group" {
  name = "${var.resource_prefix}-WEB-AUTO-SCALING"
  launch_configuration = aws_launch_configuration.web-launch-configuration.name
  vpc_zone_identifier = [aws_subnet.tier-web-private-subnet-1.id, aws_subnet.tier-web-private-subnet-2.id]

  force_delete = true

  desired_capacity   = 2
  max_size           = 4
  min_size           = 2

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "${var.resource_prefix}-WEB-ASG-EC2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "web-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.web-autoscaling-group.id
  alb_target_group_arn   = aws_lb_target_group.web-alb-target-group.arn
}

resource "aws_launch_configuration" "was-launch-configuration" {
  name   = "${var.resource_prefix}-WAS-LAUNCH-CONFIGURATION"
  image_id      = data.aws_ami.amazon-common-ami.id
  instance_type = var.was_instance_type
  iam_instance_profile = aws_iam_instance_profile.this.name

  key_name = var.instance_key_pair_name

  associate_public_ip_address = false
  security_groups = [aws_security_group.was-lc-sg.id]

  user_data = <<-EOF
            #!/bin/bash
            amazon-linux-extras install -y java-openjdk11
            wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.75/bin/apache-tomcat-8.5.75.tar.gz
            tar xvf apache-tomcat-8.5.75.tar.gz
            ./apache-tomcat-8.5.75/bin/startup.sh
            sudo yum install ruby -y
            wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
            chmod +x ./install
            sudo ./install auto
            sudo service codedeploy-agent status
            sudo service codedeploy-agent restart
            EOF
}

resource "aws_autoscaling_group" "was-autoscaling-group" {
  name = "${var.resource_prefix}-WAS-AUTO-SCALING"
  launch_configuration = aws_launch_configuration.was-launch-configuration.name
  vpc_zone_identifier = [aws_subnet.tier-was-private-subnet-1.id, aws_subnet.tier-was-private-subnet-2.id]

  force_delete = true

  desired_capacity   = 2
  max_size           = 4
  min_size           = 2

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "${var.resource_prefix}-WAS-ASG-EC2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "was-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.was-autoscaling-group.id
  alb_target_group_arn   = aws_lb_target_group.was-alb-target-group.arn
}

resource "aws_autoscaling_attachment" "external-was-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.was-autoscaling-group.id
  alb_target_group_arn   = aws_lb_target_group.external-was-alb-target-group.arn
}
