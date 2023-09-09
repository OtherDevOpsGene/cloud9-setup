locals {
  path = "/student/"
}

resource "aws_iam_group" "students" {
  name = "Students"
  path = local.path
}

data "aws_iam_policy" "cloud9" {
  arn = "arn:aws:iam::aws:policy/AWSCloud9EnvironmentMember"
}

resource "aws_iam_group_policy_attachment" "cloud9" {
  group      = aws_iam_group.students.name
  policy_arn = data.aws_iam_policy.cloud9.arn
}
