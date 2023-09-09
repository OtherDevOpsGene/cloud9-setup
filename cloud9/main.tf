locals {
  user_arn       = "arn:aws:iam::${var.aws_account}:user/${var.username}"
  instructor_arn = "arn:aws:iam::${var.aws_account}:user/${var.instructor}"
}

resource "aws_cloud9_environment_ec2" "class" {
  instance_type   = var.instance_type
  name            = var.username
  owner_arn       = local.user_arn
  connection_type = "CONNECT_SSM"
}

resource "aws_cloud9_environment_membership" "instructor" {
  environment_id = aws_cloud9_environment_ec2.class.id
  permissions    = "read-write"
  user_arn       = local.instructor_arn
}

output "cloud9" {
  value = aws_cloud9_environment_ec2.class
}

locals {
  cloud9_host  = "${var.aws_region}.console.aws.amazon.com"
  cloud9_path  = "cloud9/ide/${aws_cloud9_environment_ec2.class.id}"
  student_host = "${var.username}.cloud9.otherdevopsgene.dev"
}

resource "aws_s3_bucket" "cloud9" {
  bucket = local.student_host

  tags = {
    Student  = var.username
    Cloud9ID = aws_cloud9_environment_ec2.class.id
  }
}

resource "aws_s3_bucket_website_configuration" "redirect_cloud9" {
  bucket = aws_s3_bucket.cloud9.id

  index_document {
    suffix = "dummy.html"
  }

  routing_rule {
    redirect {
      host_name               = local.cloud9_host
      http_redirect_code      = "301"
      protocol                = "https"
      replace_key_prefix_with = local.cloud9_path
    }
  }
}

output "redirect" {
  value = aws_s3_bucket_website_configuration.redirect_cloud9
}

output "bucket" {
  value = aws_s3_bucket.cloud9
}

data "aws_route53_zone" "otherdevopsgene_dev" {
  name = "otherdevopsgene.dev"
}

resource "aws_route53_record" "cloud9_alias" {
  zone_id = data.aws_route53_zone.otherdevopsgene_dev.zone_id
  name    = local.student_host
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = aws_s3_bucket_website_configuration.redirect_cloud9.website_domain
    zone_id                = aws_s3_bucket.cloud9.hosted_zone_id
  }
}

output "route53_cname" {
  value = aws_route53_record.cloud9_alias
}
