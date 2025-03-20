provider "aws" {
    region = "ap-south"
}
resource "aws_instance" "test_instance" {
    ami = var.aws_instance
    count = var.instance_count
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = var.aws_vpc_security_group_ids
    subnet_id = var.subnet_id
     tags = {
        Name = var.instance_name
        ENV  = var.environment
}
}
resource "aws_s3_bucket" "test_bukcet"{
      bucket = var.aws_s3_bucket
    tags = {
        Name = var.aws_s3_bucket
    }
}


