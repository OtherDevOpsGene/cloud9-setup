resource "aws_iam_user" "account" {
  name          = var.username
  path          = "/student/"
  force_destroy = true
}

resource "aws_iam_user_group_membership" "students" {
  user   = aws_iam_user.account.name
  groups = ["Students"]
}

resource "aws_iam_user_login_profile" "student" {
  user    = aws_iam_user.account.name
  pgp_key = var.pub_key

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

output "acct_password" {
  value = aws_iam_user_login_profile.student.encrypted_password
}

# resource "null_resource" "reset_password" {
#   depends_on = [ aws_iam_user_login_profile.student ]

#   provisioner "local-exec" {
#     command = "aws iam update-login-profile --user-name '${var.username}' --password '${var.password}' --password-reset-required"
#     when    = create
#   }
# }
