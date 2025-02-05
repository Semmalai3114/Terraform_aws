provider "aws" {
    region = "us-east-1"
  profile = "aws1"
}
resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name="VPC1"
        ENV="env1"
    }
  
}
resource "aws_subnet" "Subnet1" {
    for_each = {
      "cidr1" = "10.0.1.0/24"
      "cidr2" = "10.0.0.0/24"
    }
    vpc_id = aws_vpc.vpc1.id
    cidr_block = each.value
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name=each.key
      ENV="env2"
    }
  
}


locals {
  subnet= {
    "vm1" = aws_subnet.Subnet1["cidr1"].id
    "vm2" = aws_subnet.Subnet1["cidr2"].id

  }
}
resource "aws_instance" "EC2" {
    
    
    #count=length(["int1","int2"])
    for_each = toset(["vm1","vm2"])
    ami = "ami-0c614dee691cbbf37"
    subnet_id = local.subnet[each.key]
    
    #depends_on = [ aws_subnet.Subnet1]
    instance_type = "t2.micro"
    tags = {
      #Name="EC2-${element(["int1", "int2"],count.index)}"
      Name="EC2-${each.value}"
    }

  
}