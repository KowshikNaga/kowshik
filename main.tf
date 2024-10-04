# Declare the variables for AWS credentials
variable "aws_access_key" {
  description = "AKIA3ISBVXA6E7KG4W3P"
  type        = string
}

variable "aws_secret_key" {
  description = "0++Ms+p0cQrBAao6vfCK4CMOwPUR6v6/paa4ol8T"
  type        = string
}

# Use the variables in the provider block
provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "instance" {
  ami           = "ami-0d1622042e957c247"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
}

