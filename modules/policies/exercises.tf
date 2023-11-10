resource "aws_iam_policy" "ec2_exercises" {
  name_prefix = "ec2"
  path        = local.path
  description = "Policy for EC2 exercises"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateKeyPair",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeInstanceCreditSpecifications",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeKeyPairs",
          "ec2:DeleteKeyPair",
          "ec2:ImportKeyPair",
          "ec2:ModifyInstanceAttribute",
          "ec2:ModifyInstanceMetadataOptions",
          "ec2:MonitorInstances",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:UnmonitorInstances",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeSecurityGroups",
          "ec2:ModifySecurityGroupRules",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
          "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
          "ec2:DescribeNetworkInterfaces"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "ec2_exercises" {
  group      = aws_iam_group.students.name
  policy_arn = aws_iam_policy.ec2_exercises.arn
}

resource "aws_iam_policy" "s3_state_exercise" {
  name_prefix = "s3-state"
  path        = local.path
  description = "Policy for S3 state bucket exercise"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:CreateTable",
          "dynamodb:DeleteItem",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTable",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:GetItem",
          "dynamodb:ListTagsOfResource",
          "dynamodb:PutItem",
          "dynamodb:TagResource",
          "dynamodb:UntagResource",
          "dynamodb:UpdateContinuousBackups",
          "dynamodb:UpdateTable",
          "dynamodb:UpdateTimeToLive"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeAccountAttributes"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Sid" : "VisualEditor2",
        "Effect" : "Allow",
        "Action" : [
          "iam:AttachRolePolicy",
          "iam:CreatePolicy",
          "iam:CreateRole",
          "iam:DeletePolicy",
          "iam:DeleteRole",
          "iam:DeleteRolePermissionsBoundary",
          "iam:DetachRolePolicy",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:ListInstanceProfilesForRole",
          "iam:ListPolicyVersions",
          "iam:ListRolePolicies",
          "iam:PassRole",
          "iam:PutRolePermissionsBoundary",
          "iam:TagPolicy",
          "iam:TagRole",
          "iam:UntagPolicy"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Sid" : "VisualEditor3",
        "Effect" : "Allow",
        "Action" : [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:DeleteBucketPolicy",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLogging",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketOwnershipControls",
          "s3:GetBucketPolicy",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketWebsite",
          "s3:GetEncryptionConfiguration",
          "s3:GetIntelligentTieringConfiguration",
          "s3:GetLifecycleConfiguration",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectTagging",
          "s3:GetReplicationConfiguration",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:PutBucketAcl",
          "s3:PutBucketLogging",
          "s3:PutBucketOwnershipControls",
          "s3:PutBucketPolicy",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutBucketTagging",
          "s3:PutBucketVersioning",
          "s3:PutEncryptionConfiguration",
          "s3:PutIntelligentTieringConfiguration",
          "s3:PutReplicationConfiguration"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "s3_state_exercise" {
  group      = aws_iam_group.students.name
  policy_arn = aws_iam_policy.s3_state_exercise.arn
}
