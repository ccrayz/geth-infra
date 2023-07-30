locals {
  ingress_rules = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    },
    {
      description = "Geth RPC"
      from_port   = 8545
      to_port     = 8545
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    },
    {
      description = "Geth WC"
      from_port   = 8546
      to_port     = 8546
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    },
    {
      description = "Geth Admin"
      from_port   = 8551
      to_port     = 8551
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    },
    {
      description = "Geth P2P TCP"
      from_port   = 30303
      to_port     = 30303
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Geth P2P UDP"
      from_port   = 30303
      to_port     = 30303
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
resource "aws_security_group" "geth" {
  name        = "geth-sg"
  description = "security group for geth"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "geth-sg"
  }
}

