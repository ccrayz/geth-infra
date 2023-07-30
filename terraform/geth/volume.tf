resource "aws_ebs_volume" "geth" {
  availability_zone = var.availability_zones[0]
  size              = var.volume_size
  type              = "gp3"
  iops              = 3000
  throughput        = 125

  tags = {
    Name = "Geth DB Volume"
  }
}

resource "aws_volume_attachment" "geth_ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.geth.id
  instance_id = aws_instance.geth[0].id
}
