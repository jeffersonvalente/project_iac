provider "aws" {
  region = "us-east-1"
  #chaves aws salvas localmente
  profile ="tf01"
}

# Criar vpc
resource "aws_vpc" "main" {
  cidr_block                     = "10.16.0.0/16"
  enable_dns_support             = "true"
  enable_dns_hostnames           = "true"

    tags = {
    Name = "projeto_iac"
  }
}