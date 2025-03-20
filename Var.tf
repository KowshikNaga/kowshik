variable "aws_instance" {
  type = string
  default = "ami-08fe5144e4659a3b3"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_count" {
  type = number
  default = 2
}

variable "key_name" {
  type = string
  default = "main"
}

variable "aws_vpc_security_group_ids" {
  type =list(string) 
  default = ["sg-001966d6a9e97b1c0"]  
}

variable "subnet_id" {
  type = string
  default = "subnet-04583618c5b90f807"
}

variable "instance_name" {
  type    = string
  default = "MyInstance"
}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "aws_s3_bucket" {
  type = string
  default = "mybucket-10-22-aviva"
}

