resource "aws_key_pair" "geth" {
  key_name   = "geth-keypair"
  public_key = file("../../ssh/geth.pub")
}

resource "aws_launch_template" "geth" {
  name = "geth-launch-template"

  disable_api_stop        = false
  disable_api_termination = false

  ebs_optimized                        = true
  image_id                             = var.ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type

  key_name = aws_key_pair.geth.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    network_interface_id = aws_network_interface.geth.id
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "geth-instance"
    }
  }

  update_default_version = true
  user_data              = filebase64("scripts/install.sh")
}

resource "aws_instance" "geth" {
  count = 1

  associate_public_ip_address = true

  launch_template {
    id      = aws_launch_template.geth.id
    version = "$Latest"
  }
}
