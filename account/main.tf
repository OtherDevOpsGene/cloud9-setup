resource "aws_iam_user" "account" {
  name          = var.username
  path          = "/student/"
  force_destroy = true

  # provisioner "local-exec" {
  #   command = "aws iam update-login-profile --username ${var.username} --password ${var.password} --password-reset-required"
  #   when    = create
  # }
}

# resource "aws_iam_user_group_membership" "student" {
#   user = aws_iam_user.account.name
#   groups = [
#     aws_iam_group.group3.name,
#   ]
# }
