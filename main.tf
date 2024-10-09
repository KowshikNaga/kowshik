provider "aws" {
  region = "ap-south-1"  # Change to your preferred region
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0d1622042e957c247"  # AMI ID
  instance_type          = "t2.micro"               # Instance type
  key_name               = "main"                   # SSH key
  subnet_id              = "subnet-03c5a2fff3bbfa559" # Subnet ID

  # Network Interface with public IP and security group
  network_interface {
    device_index          = 0
    subnet_id             = "subnet-03c5a2fff3bbfa559"  # Subnet ID
    associate_public_ip_address = true
    security_groups       = ["sg-001966d6a9e97b1c0"]  # Security Group ID
  }

  # Credit specification for T2 instance types (standard mode)
  credit_specification {
    cpu_credits = "standard"
  }

  # Metadata Options
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  # Private DNS Name Options
  private_dns_name_options {
    hostname_type                  = "ip-name"
    enable_resource_name_dns_a_record  = false
    enable_resource_name_dns_aaaa_record = false
  }

  # Tags
  tags = {
    Name = "Project"
  }

  # Count for EC2 instances (MinCount and MaxCount equivalent)
  count = 6
}
