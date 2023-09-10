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

resource "aws_s3_bucket_ownership_controls" "cloud9" {
  bucket = aws_s3_bucket.cloud9.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "cloud9" {
  bucket = aws_s3_bucket.cloud9.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "public" {
  depends_on = [
    aws_s3_bucket_ownership_controls.cloud9,
    aws_s3_bucket_public_access_block.cloud9,
  ]

  bucket = aws_s3_bucket.cloud9.id
  acl    = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "cloud9" {
  bucket = aws_s3_bucket.cloud9.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
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
      http_redirect_code      = "302"
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

resource "aws_route53_record" "cloud9_cname" {
  zone_id = data.aws_route53_zone.otherdevopsgene_dev.zone_id
  name    = local.student_host
  type    = "CNAME"
  ttl     = 60

  records = [aws_s3_bucket_website_configuration.redirect_cloud9.website_endpoint]
}

output "route53_cname" {
  value = aws_route53_record.cloud9_cname
}
