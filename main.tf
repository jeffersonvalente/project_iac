#pega as zonas disponiveis
data "aws_availability_zones" "available" {
state = "available"
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
  vpc_id = aws_vpc.main.id
  #adicionado +1 no count.index + 1, pois gerava erro quando criava a rede 10.16.0.0/20
  cidr_block              = cidrsubnet(var.vpc_cidr, 4 , count.index + 1)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
}

# cria um numero de subnets privadas igual a count, adiciona o bloco conforme o contador e adiciona as zonas conforme o contador
resource "aws_subnet" "private" {
  count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

tags = merge(
    var.tags,
    {
      Name = format("%s-PrivateSubnet-%s", var.name, count.index)
    },
  )

}
