locals {
  path                 = "/student/"
  class_day_in_seconds = 10 * 60 * 60
}

resource "aws_iam_role" "student" {
  name = "Student"
  path = local.path

  max_session_duration = local.class_day_in_seconds

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_group" "students" {
  name = "Students"
  path = local.path
}
