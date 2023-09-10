locals {
  user_arn       = "arn:aws:iam::${var.aws_account}:user/student/${var.username}"
  instructor_arn = "arn:aws:iam::${var.aws_account}:user/${var.instructor}"
}

resource "aws_cloud9_environment_ec2" "student" {
  instance_type   = var.instance_type
  name            = var.username
  owner_arn       = local.user_arn
  connection_type = "CONNECT_SSM"
}

resource "aws_cloud9_environment_membership" "instructor" {
  environment_id = aws_cloud9_environment_ec2.student.id
  permissions    = "read-write"
  user_arn       = local.instructor_arn
}

output "cloud9_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.student.id}"
}
