terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.89.0"
    }
  }

  backend "gcs" {
    bucket  = "lws-dev-common-bucket"
    prefix  = "global/networking.state"
  }

  required_version = ">= 0.14.9"
}

provider "google" {
  project = var.project_id
  region  = var.region
}


#Custom Created Module in this repo
module "vpc" {
  source  = "../../Modules/VPC"

  vpc_name   = "lws-${var.env_name}-common-vpc" 
  subnets    = {
    "EKSSubnet" ={
      subnet_name = "lws-${var.env_name}-uswest1-eks-subnet" 
      subnet_ip_range = "10.0.0.0/24"
      subnet_region = "uswest1"
      private_ip_google_access = true
    }
  }

}

#Preconfigured Terraform Google Module
