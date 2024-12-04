terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

provider "docker" {
  host = "unix:///var/run/docker.sock" 
}
