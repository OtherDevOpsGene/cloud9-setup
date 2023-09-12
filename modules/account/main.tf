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

  password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

output "password" {
  value = aws_iam_user_login_profile.student.encrypted_password
}
