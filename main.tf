provider "aws" {
    region="us-west-2"
}

# Create our VPC
resource "aws_vpc" "risper-application-deployment" {
  cidr_block = "10.6.0.0/16"

  tags = {
    Name = "risper-application-deployment-vpc"
  }
}

resource "aws_internet_gateway" "risper-ig" {
    vpc_id = "${aws_vpc.risper-application-deployment.id}"

    tags = {
        Name = "risper-ig"
    }
}

resource "aws_route_table" "risper-rt" {
    vpc_id = "${aws_vpc.risper-application-deployment.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.risper-ig.id}"
    }
  
}

module "application-tier" {
    name = "risper-app"
    source = "./modules/application-tier"
    vpc_id = "${aws_vpc.risper-application-deployment.id}"
    route_table_id = "${aws_route_table.risper-rt.id}"
    cidr_block = "10.6.0.0/24"
    user_data=templatefile("./scripts/app_user_data.sh", {})
    ami_id = "ami-04ddea7950cd45651"
    
    map_public_ip_on_launch = true
    
    ingress = [
        { from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"}
        ,{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "2.24.255.17/32"
    },{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "3.144.48.26/32"
    } ]
}
