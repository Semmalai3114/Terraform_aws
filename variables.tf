variable "vpc" {
    type=list(object({
        vpc_name=string
      vpc_id = string
      tags=map(string)
    }))
}
variable "subnets" {
    type =list(object({
      sub_name=string
    vpc_name = string
    cidr_value=string
    map_value=bool
    tags=map(string)
    }))
  
}
variable "igw" {
    type =list(object({
     igw_name=string
      vpc_name = string
     
      tags=map(string)
    })) 
}
variable "instance" {
    type = list(object({
        sub_name= string
        vpc_name=string
        ec2_name=string
        security_name=string
        ami=string
        ip=bool
        instance_type=string
        tags=map(string)
    }))
  
}
variable "peering" {
    type = list(object({
      vpc_name= string
      vpc_peer=string
      accepter=bool
      tags=map(string)
    }))
    
}
variable "router" {
  type = list(object({
    route_name = string
    cidr_value=string
    igw_name=string
    sub_name=string
    vpc_name=string
    bool1=bool
    tags=map(string)
  }))
  
}
variable "rta" {
  type = list(object({
    vpc_name = string
    sub_name=string
    rta_name=string
  }))
  
}
variable "Entry" {
    type = list(object({
      vpc_name = string
      dest_name=string
      peering=string
      
      tags=map(string)
    }))
  
}
variable "security" {
  type = list(object({
    security_name =string
    name=string
    vpc_name=string 
    tags=map(string)
  }))
  
}