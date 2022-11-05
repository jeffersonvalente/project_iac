# grupo de segurança para que o load balance permitir qualquer trafego http https
resource "aws_security_group" "ext-alb-sg" {
  name        = "ext-alb-sg"
  vpc_id = aws_vpc.main.id
  description = "permite trafico de entrada"

#entrada http
ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
#entrada https
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
#saida
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 tags = merge(
    var.tags,
    {
      Name = "sg-lb-externo"
    },
  )

}
