provider "aws" {
  region = "us-east-2"
#  shared_config_files      = ["~/.aws/config"]
  shared_credentials_file = "~/.aws/credentials"
  profile                  = "snap"
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}
/*
resource "aws_s3_bucket" "state-bucket" {
  bucket = "snap-tf-state-bucket"

  tags = {
    Name        = "Lower envs State bucket"
    Environment = "Lower envs"
  }
}
*/


terraform {
  backend "s3" {
    bucket         = "snap-tf-state-bucket"
    key            = "uat/terraform.tfstate"
    region         = "us-east-2"
  }
}

