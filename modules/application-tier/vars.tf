variable "vpc_id" {
    description = "The VPC ID in AWS"
  
}

variable "name" {
    description = "Name to be used for the Tags"
  
}
variable "route_table_id" {
     description = "Route table ID"
}
variable "cidr_block" {
     description = "Cider block"
}
variable "user_data" {
     description = "User Data"
}
variable "ami_id" {
     description = "AMI ID"
}
variable "map_public_ip_on_launch" {
     description = "Map public IP on launch"
     default = false
}

variable "ingress" {
     description = "Ingress"
     type = list
  
}
