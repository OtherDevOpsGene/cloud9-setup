data "aws_security_group" "cloud9" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
      aws_cloud9_environment_ec2.student.id
    ]
  }
}

# resource "aws_vpc_security_group_ingress_rule" "https" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 443
#   to_port           = 443
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "http" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   to_port           = 80
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "http8080" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 8080
#   to_port           = 8080
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "nodeport" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 30000
#   to_port           = 32768
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "selenium_grid" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 4444
#   to_port           = 4444
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "kubectl" {
#   security_group_id = data.aws_security_group.cloud9.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 6443
#   to_port           = 6443
#   ip_protocol       = "tcp"
# }