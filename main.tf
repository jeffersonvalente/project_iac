#pega as zonas disponiveis
data "aws_availability_zones" "available" {
state = "available"
}
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
  default = 2
}

provider "aws" {
  region = var.region
  #chaves aws salvas localmente
  profile ="tf01"
}

# Criar vpc
resource "aws_vpc" "main" {
  cidr_block                     = var.vpc_cidr
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames

    tags = {
    Name = "projeto_iac"
  }
}
# cria um numero de subnets publicas igual a count, adiciona o bloco conforme o contador e adiciona as zonas conforme o contador
resource "aws_subnet" "public" {
  count  = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
}