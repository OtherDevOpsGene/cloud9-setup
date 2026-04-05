locals {
  user_arn       = "arn:aws:iam::${var.aws_account}:user/${var.username}"
  instructor_arn = "arn:aws:iam::${var.aws_account}:user/${var.instructor}"
}

resource "aws_cloud9_environment_ec2" "student" {
  description     = "${var.username}'s workspace"
  instance_type   = var.instance_type
  name            = var.username
  owner_arn       = local.user_arn
  image_id        = "amazonlinux-2023-x86_64"
  connection_type = "CONNECT_SSM"

  tags = {
    Student = var.username
  }
}

resource "aws_cloud9_environment_membership" "instructor" {
  environment_id = aws_cloud9_environment_ec2.student.id
  permissions    = "read-write"
  user_arn       = local.instructor_arn
}

output "cloud9_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.student.id}"
}

data "aws_instance" "cloud9_instance" {
  filter {
    name   = "tag:aws:cloud9:environment"
    values = [aws_cloud9_environment_ec2.student.id]
  }
}

data "aws_route53_zone" "hosted_domain" {
  for_each = toset(var.domains)
  name = each.value
}

resource "aws_route53_record" "www" {
  for_each = data.aws_route53_zone.hosted_domain

  zone_id = each.value.zone_id
  name    = "${var.username}.${var.subdomain}.${each.value.name}"
  type    = "A"
  ttl     = 300
  records = [data.aws_instance.cloud9_instance.public_ip]
}
