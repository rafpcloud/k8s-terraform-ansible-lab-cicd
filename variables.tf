
variable "vpc_cidr" {

  default = "192.168.0.0/16"

}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default = {
    "Name" = "MASTER01"
    "Name" = "NODE01"
    "Name" = "NODE02"
  }
}