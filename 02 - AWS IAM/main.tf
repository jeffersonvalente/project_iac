#pega as zonas disponiveis
data "aws_availability_zones" "available" {
state = "available"
}

provider "aws" {
  region = var.region
  #chaves aws salvas localmente
  profile ="tf01"
}
