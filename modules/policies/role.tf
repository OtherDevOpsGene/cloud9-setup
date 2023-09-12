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

resource "aws_iam_policy" "change_student_own_password" {
  name_prefix = "student-password"
  path        = local.path
  description = "Policy for /student/ to change their own password"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:ChangePassword"
        ],
        "Resource" : [
          "arn:aws:iam::*:user/student/$${aws:username}"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:GetAccountPasswordPolicy"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "change_own_password" {
  group      = aws_iam_group.students.name
  policy_arn = aws_iam_policy.change_student_own_password.arn
}
