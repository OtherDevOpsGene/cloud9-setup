module "tfstate-backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.4.1"

  namespace  = "otherdevopsgene"
  name       = "cloud9-class"

  force_destroy = false
}

output "terraform_backend_config" {
  value = module.tfstate-backend.terraform_backend_config
}
