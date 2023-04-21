terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      School  = var.school
      Project = var.project
    }
  }
}

module "network" {
  source  = "./modules/network"
  
  private_subnets = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
  public_subnets = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

module "compute" {
  source  = "./modules/compute"
  
  private_subnets_ids= module.network.private_subnets_ids
}


