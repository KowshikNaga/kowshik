# Declare the variables for AWS credentials
variable "aws_access_key" {
  description = "AKIA3ISBVXA6KCV7BFWD"
  type        = string
}

variable "aws_secret_key" {
  description = "1S1sZSiMsPWQxo4TFJ2KJh3FTSopbCThSCh+RWqY"
  type        = string
}

# Use the variables in the provider block
provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "example" {
  ami           = "ami-0d1622042e957c247"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
}

