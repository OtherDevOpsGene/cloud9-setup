resource "aws_ecr_repository" "favorites" {
  name                 = "favorites"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_iam_policy" "ecr_exercises" {
  name_prefix = "ecr"
  path        = local.path
  description = "Policy for ECR exercises"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:TagResource",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "ecr_exercises" {
  group      = aws_iam_group.students.name
  policy_arn = aws_iam_policy.ecr_exercises.arn
}
