variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "portfolio-site"
}

variable "environment" {
  description = "Environment name (e.g., production, staging)"
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Optional custom domain name for CloudFront"
  type        = string
  default     = ""
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}
