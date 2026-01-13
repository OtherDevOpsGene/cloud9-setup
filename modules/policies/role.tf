locals {
  path = "/"
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
  description = "Policy for students to change their own password"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:ChangePassword"
        ],
        "Resource" : [
          "arn:aws:iam::*:user/$${aws:username}"
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


resource "aws_iam_policy" "access_key" {
  name_prefix = "student-password"
  path        = local.path
  description = "Policy for students to generate an access key"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateAccessKey",
                "iam:ListAccessKeys",
                "iam:UpdateAccessKey",
                "iam:DeleteAccessKey"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "access_key" {
  group      = aws_iam_group.students.name
  policy_arn = aws_iam_policy.access_key.arn
}

data "aws_iam_policy" "ssm" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_group_policy_attachment" "ssm" {
  group      = aws_iam_group.students.name
  policy_arn = data.aws_iam_policy.ssm.arn
}

resource "aws_iam_instance_profile" "cloud9_profile" {
  name = "cloud9_profile"
  role = aws_iam_role.cloud9.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cloud9" {
  name               = "cloud9_profile"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
