vpc=[{
  tags = {
    Name = "vpc1"
  }
  vpc_id = "10.0.0.0/16"
  vpc_name = "vpc1"
},{
  tags = {
    Name = "vpc2"
  }
  vpc_id = "11.0.0.0/16"
  vpc_name = "vpc2"
}]

subnets=[{
  sub_name="subnet1"
  cidr_value = "10.0.1.0/24"
  map_value = true
  tags = {
    Name = "sub1"
  }
  vpc_name = "vpc1"
},{
  sub_name="subnet2"
  cidr_value = "11.0.1.0/24"
  map_value = false
  tags = {
    Name = "sub2"
  }
  vpc_name = "vpc2"
}]


igw = [ {
    igw_name = "igw1"
  vpc_name = "vpc1"
  tags = {
    Name = "IGW1"
  }

} ]


instance = [ {
  vpc_name="vpc1"
  sub_name = "subnet1"
  ec2_name = "instance1"
  ip = true
  security_name = "Security1"
  ami="ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  tags = {
    Name = "instance1"
  }
} ,
{
  sub_name = "subnet2"
  vpc_name="vpc2"
  ec2_name = "instance2"
  security_name = "Security2"
  ami="ami-0fff1b9a61dec8a5f"
  ip = false
  instance_type = "t2.micro"
  tags = {
    Name = "instance2"
  }
  }
  ]


peering = [ 
  {
  vpc_name = "vpc1"
  vpc_peer = "vpc2"
  accepter = true
  tags = {
    Name= "peering"
  }
} ]


router = [ {
  route_name = "router1"
  vpc_name = "vpc1"
  cidr_value = "0.0.0.0/0"
  igw_name = "igw1"
  bool1 = true
  sub_name="subnet1"
  tags = {
    Name = "route1"
  }
}, {
  route_name = "router2"
  vpc_name = "vpc2"
  sub_name="subnet2"
  cidr_value = "0.0.0.0/0"
  igw_name = ""
  tags = {
    Name = "route2"
  }
} ]


Entry = [ {
  vpc_name = "vpc1"
  dest_name = "vpc2"
  cidr_block = "11.0.0.0/16"
 peering = "vpc1"
  tags = {
    Name= "Entry1"
  }
},{
  vpc_name = "vpc2"
  dest_name = "vpc1"
  peering = "vpc1"
   tags = {
    Name= "Entry2"
  }
  }]


  rta = [ {
    vpc_name = "vpc1"
    sub_name = "subnet1"
    rta_name = "rta1"
  },{
    vpc_name = "vpc2"
    sub_name = "subnet2"
    rta_name = "rta2"
  }, ]

  
  security = [ {
    security_name = "Security1"
    name = "Security1"
    vpc_name = "vpc1"
    tags = {
      Name = "Security1"
    }
  } ,{
    security_name = "Security2"
    name = "Security2"
    vpc_name = "vpc2"
     tags = {
      Name = "Security2"
    }
  } ]