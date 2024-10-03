terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3ISBVXA6KCV7BFWD"
  secret_key = "1S1sZSiMsPWQxo4TFJ2KJh3FTSopbCThSCh+RWqY"

}

resource "aws_instance" "example" {
  ami           = "ami-0d1622042e957c247"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
}
