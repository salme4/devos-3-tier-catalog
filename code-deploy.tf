resource "aws_codedeploy_app" "this" {
  name = "${var.resource_prefix}-CodeDeploy-Application"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "${var.resource_prefix}-Deployment-Group"
  service_role_arn      = aws_iam_role.codedeploy-service.arn
  autoscaling_groups = [aws_autoscaling_group.was-autoscaling-group.name]

  auto_rollback_configuration {
    enabled = true
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }
}
