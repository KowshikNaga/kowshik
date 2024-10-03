provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d1622042e957c247"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
}
