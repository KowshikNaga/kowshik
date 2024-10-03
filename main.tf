terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "1.9.7"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {
  description = "AKIA3ISBVXA6KCV7BFWD"
  type        = string
}

variable "aws_secret_key" {
  description = "1S1sZSiMsPWQxo4TFJ2KJh3FTSopbCThSCh+RWqY"
  type        = string
}

resource "aws_instance" "example" {
  ami           = "ami-0d1622042e957c247 "  # Replace with a valid AMI ID
  instance_type = "t2.micro"
}
