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
#nuemro de subnets a adicionar
variable "preferred_number_of_public_subnets" {
  default = null
}
