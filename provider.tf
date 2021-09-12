terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.57.0"
    }
  }
}
provider "aws" {
  access_key = "AKIA4XK7UFHMTJMVUCXL"
  secret_key = "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"
  region     = var.aws_region
}
