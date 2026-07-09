# Terraform State Backend Configuration
#
# IMPORTANT: Do NOT uncomment this on your first run!
#
# To set up remote state management:
# 1. First run: `terraform init` (without backend config - uses local state)
# 2. Run: `terraform apply` to create the resources
# 3. Create an S3 bucket for Terraform state (outside this configuration)
# 4. Uncomment the terraform block below
# 5. Run: `terraform init -migrate-state` (this will migrate local state to S3)
#
# After that, all terraform operations will use remote state.

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "portfolio-site/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
