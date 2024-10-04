provider "aws" {
    region = "us-east-1"
    secret_key = ""
    access_key = ""
    profile = "terra1"
  
}
resource "aws_vpc" "name" {
    for_each = { for i in var.vpc :  i.vpc_name=> i}
    cidr_block = each.value.vpc_id
    tags = each.value.tags
    
  
  
}

resource "aws_subnet" "subnets" {
    for_each = { for j in var.subnets : "${j.vpc_name}-${j.sub_name}"=> j}
    vpc_id = aws_vpc.name[each.value.vpc_name].id
    cidr_block = each.value.cidr_value
    map_public_ip_on_launch = each.value.map_value
    tags = each.value.tags
  
}

resource "aws_internet_gateway" "igw" {
    for_each = { for i in var.igw : i.igw_name =>i}
    vpc_id = aws_vpc.name[each.value.vpc_name].id
    tags= each.value.tags
    }
    
resource "aws_instance" "instance" {
    for_each = { for i in var.instance : "${i.sub_name}-${i.ec2_name}" => i}
    subnet_id = aws_subnet.subnets["${each.value.vpc_name}-${each.value.sub_name}"].id
    ami = each.value.ami
    security_groups = [aws_security_group.as["${each.value.security_name}"].id]
    associate_public_ip_address = each.value.ip
    instance_type = each.value.instance_type
    tags = each.value.tags
}
resource "aws_vpc_peering_connection" "peering" {
    for_each = { for i in var.peering : i.vpc_name=>i}
    vpc_id = aws_vpc.name[each.value.vpc_name].id
    peer_vpc_id = aws_vpc.name[each.value.vpc_peer].id
    tags = each.value.tags
    auto_accept = each.value.accepter
}

resource "aws_route_table" "routers" {
    for_each = { for i in var.router : i.vpc_name=>i}
    
    vpc_id = aws_vpc.name[each.value.vpc_name].id
    tags = each.value.tags
   
   route {
    cidr_block = each.value.cidr_value
    gateway_id = aws_internet_gateway.igw["${each.value.igw_name}"].id
  }
}
resource "aws_route_table_association" "rta" {
    for_each = { for i in var.rta : i.rta_name=>i}
    subnet_id = aws_subnet.subnets["${each.value.vpc_name}-${each.value.sub_name}"].id
    route_table_id = aws_route_table.routers[each.value.vpc_name].id
  
}
resource "aws_route" "Entry_points" {
    for_each = {for i in var.Entry : "${i.vpc_name}-${i.dest_name}"=>i}
    route_table_id = aws_route_table.routers[each.value.vpc_name].id
    destination_cidr_block = aws_vpc.name[each.value.dest_name].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[each.value.peering].id
  
}
resource "aws_security_group" "as" {
    for_each = {for i in var.security : i.security_name=>i}
    name = each.value.name
    vpc_id = aws_vpc.name["${each.value.vpc_name}"].id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    tags =each.value.tags
  
}
