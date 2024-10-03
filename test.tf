provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-west-2"  # Specify your AWS region
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0d1622042e957c247"  # Replace with your desired AMI
  instance_type = "t2.micro"               # Instance type
  tags = {
    Name = "MyNewEC2Instance"
  }
}

# Define variables for the AWS credentials
variable "aws_access_key" {
  description = "AKIA3ISBVXA6KCV7BFWD"

}

variable "aws_secret_key" {
  description = "1S1sZSiMsPWQxo4TFJ2KJh3FTSopbCThSCh+RWqY"
}
