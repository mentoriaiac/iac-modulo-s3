terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "bucket_name" {
  type = string
}

variable "acl" {
  type    = string
  default = "private"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = var.acl
}
