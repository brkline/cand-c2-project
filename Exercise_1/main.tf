# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
    profile = "default"
    region  = "us-west-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
   ami              = "ami-06fcc1f0bc2c8943f"
   instance_type    = "t2.micro"
   count            = 4
   tags = {
      Name = "Udacity T2"
   }    
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
   ami            = "ami-06fcc1f0bc2c8943f"   
   instance_type  = "m4.large"
   count          = 2
   tags = {
      Name = "Udacity M4"
   }   
}