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
# criar subnet publica 10.16.0.0/16 em "us-east-1a"
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.16.0.0/24"
  map_public_ip_on_launch = true
  availability_zone =  "us-east-1a"

  tags = {
    Name = "us -east-1a"
  }
}

# criar subnet publica 10.16.1.0/16 em "us-east-1a"
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone =  "us-east-1b"

  tags = {
    Name = "us-east-1b"
  }
}