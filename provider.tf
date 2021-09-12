terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.57.0"
    }
  }
}
provider "aws" {
  access_key = "AKIA4XK7UFHM7WPBKPVM"
  secret_key = "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"
  region     = var.aws_region
}