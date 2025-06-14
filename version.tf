terraform {
 required_providers {
 aws = {
 source = "hashicorp/aws"
 version = "~> 5.0"
 }
 }
 backend "s3" {
 bucket = "demo-terraform-eks-state-s3-bucket"
 key = "terraform.tfstate"
 region = "us-west-2"
 dynamodb_table = "terraform-eks-state-locks"
 encrypt = true
 }
}
provider "aws" {
 region = var.region
}
