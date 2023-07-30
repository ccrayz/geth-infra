resource "aws_network_interface" "geth" {
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.geth.id]
  private_ips     = ["10.0.0.10"]

  tags = {
    Name = "geth-eni"
  }
}

resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.geth.id
  associate_with_private_ip = "10.0.0.10"

  tags = {
    Name = "geth-eip"
  }
}
