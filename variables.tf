
variable  "vpc_cidr" {

default = "192.168.0.0/16"

}

#variable "instance_tags" {
#  type = list(string)

#  default = ["MASTER01",
#             "MASTER02",
#             "MASTER03",
#             "NODE01",
#             "NODE02",
#             "NODE03"
#            ]
#}




variable "availability_zone" {
    type = map
    default = {
    "us-east-1" = "us-east-1a"
    "us-east-2" = "us-east-2b"
    "us-east-2" = "us-east-2c"   
     }
  
}

variable "aws_region" {

  default = "us-east-1"  

}

variable "instance_count" {
default = "6" 
}



