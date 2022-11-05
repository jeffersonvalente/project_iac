#adiciona a variavel região
variable "region" {
        default = "us-east-1"
    }
#adiciona a variavel block de ip
variable "vpc_cidr" {
        default = "10.16.0.0/16"
    }
#adiciona a variavel de dns
variable "enable_dns_support" {
        default = "true"
    }
#adiciona a variavel de hostnames
variable "enable_dns_hostnames" {
        default ="true" 
    }
#nuemro de publicas subnets a adicionar
variable "preferred_number_of_public_subnets" {
  default = null
}

#nuemro de privadas subnets a adicionar
variable "preferred_number_of_private_subnets" {
  default = null
}
variable "name" {
    type = string
    default = "jeff"
    
}
variable "tags" {
    type    = map(string)
    default = {}
}
variable "ami" {
  type        = string
}
variable "keypair" {
  type        = string
}
variable "account_no" {
  type        = number
}
variable "master-username" {
  type        = string
}
variable "master-password" {
  type        = string
}
variable "db_name" {
  type        = string
}