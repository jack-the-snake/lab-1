terraform {
  required_version = "~>1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.5.0"
    }
  }
}


provider "aws" {

}

provider "http" {
  # Configuration options
}


data "http" "terraform_version" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"
}

locals {
  terraform_details = jsondecode(data.http.terraform_version.response_body)
}


# Terraform 1.14.2 (1765457324)
output "info" {
  value = "Terraform ${local.terraform_details.current_version} (${local.terraform_details.current_release})"
}




