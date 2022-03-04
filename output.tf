output "bastion-public-ip" {
  value = aws_instance.bastion-ec2.public_ip
  description = "Bastion Public IP Address"
}

output "web-alb-dns" {
  value = aws_lb.web-alb.dns_name
  description = "WEB ALB DNS Name"
}

output "was-alb-dns" {
  value = aws_lb.was-alb.dns_name
  description = "WAS ALB DNS Name"
}


output "external-was-alb-dns" {
  value = aws_lb.external-was-alb.dns_name
  description = "EXTERNAL WAS ALB DNS Name"
}

output "codeDeploy-application" {
  value = aws_codedeploy_app.this.name
  description = "Code Deploy Application Name"
}

output "codeDeploy-deployment-group" {
  value = aws_codedeploy_deployment_group.this.deployment_group_name
  description = "Code Deploy Deployment Group"
}

output "s3-bucket" {
  value = aws_s3_bucket.bucket.id
  description = "S3 Bucket Name"
}
