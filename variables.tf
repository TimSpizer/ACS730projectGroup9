variable "inbound_ec2" {
  type        = list(any)
  default     = [22, 80]
  description = "inbound port allow on production instance"
}
 
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
 
variable "ami" {
  type    = string
  default = "ami-051f8a213df8bc089"
}
 
variable "key_name" {
  type    = string
  default = "ec2Key"
}
 
variable "availability_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#dev environment configuration of vps and subnets 
variable "vpc_cidr" {
  type    = string
  default = "10.100.0.0/16"
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = list(string)
  default     = ["10.100.101.0/24", "10.100.102.0/24", "10.100.103.0/24"]
}
# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = list(string)
  default     = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}



#for staging environment you can use the following values and comment the above for dev.

#variable "vpc_cidr" {
#  type    = string
#  default = "10.200.0.0/16"
#}

# VPC Public Subnets
#variable "vpc_public_subnets" {
#  description = "VPC Public Subnets"
#  type        = list(string)
#  default     = ["10.200.101.0/24", "10.200.102.0/24", "10.200.103.0/24"]
#}

# VPC Private Subnets
#variable "vpc_private_subnets" {
# description = "VPC Private Subnets"
#  type        = list(string)
#  default     = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
}

#for dev environment you can use the following values and comment the above for dev.

#variable "vpc_cidr" {
#  type    = string
#  default = "10.250.0.0/16"
#}


# VPC Public Subnets
#variable "vpc_public_subnets" {
#  description = "VPC Public Subnets"
#  type        = list(string)
#  default     = ["10.250.101.0/24", "10.250.102.0/24", "10.250.103.0/24"]
#}


# VPC Private Subnets
#variable "vpc_private_subnets" {
# description = "VPC Private Subnets"
#  type        = list(string)
#  default     = ["10.250.1.0/24", "10.250.2.0/24", "10.250.3.0/24"]
}

