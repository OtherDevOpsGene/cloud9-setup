module "tfstate-backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.1.1"

  namespace  = "otherdevopsgene"
  name       = "cloud9-class"
  attributes = ["gg", "tf"]

  force_destroy = false
}

output "terraform_backend_config" {
  value = module.tfstate-backend.terraform_backend_config
}
