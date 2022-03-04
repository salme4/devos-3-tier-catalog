resource "aws_iam_role" "codedeploy-service" {
  name = "${var.resource_prefix}-CodeDeploy-Service-Role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codedeploy.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codedeploy-service-attachment" {
  role       = aws_iam_role.codedeploy-service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role" "instance-profile" {
  name = "${var.resource_prefix}-CodeDeploy-Instance-Profile"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "instance-profile-codedeploy-attachment" {
  role       = aws_iam_role.instance-profile.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.resource_prefix}-codedeploy-instance-profile"
  role = aws_iam_role.instance-profile.name
}
