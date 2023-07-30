terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = ">= 1.0.0"
  }

  backend "s3" {
    bucket         = "ray-apn2-tfstate"
    key            = "terraform/geth.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "ray-apn2-tfstate-terraform-lock"
  }
}
