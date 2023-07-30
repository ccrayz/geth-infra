output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "geth_eip" {
  value = aws_eip.one.public_ip
}

output "geth_eni" {
  value = aws_network_interface.geth.private_ip
}

output "ec2_key_pair" {
  value = aws_key_pair.geth.key_name
}

output "ec2_public_ip" {
  value = aws_eip.one.public_ip
}

output "ec2_private_ip" {
  value = aws_network_interface.geth.private_ip
}

output "geth_sg_id" {
  value = aws_security_group.geth.id
}

output "geth_sg_name" {
  value = aws_security_group.geth.name
}

output "ebs_volume_id" {
  value = aws_ebs_volume.geth.id
}
 
