terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.57.0"
    }
  }
}
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-central-1"
}
