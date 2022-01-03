data "aws_ami" "amazonlinux_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "public" {
 for_each        = aws_subnet.public
  ami             = data.aws_ami.amazonlinux_ami.id
  instance_type   = "t2.medium"
  key_name        = aws_key_pair.ssh-key.key_name
  subnet_id       = each.value.id
  security_groups = [aws_security_group.sgweb.id]

  tags = {

 Name = each.key == "0" ? "MASTER" : "NODE${each.key}" 

  }

}


resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjiKMnK9QroK0+eSgFH/bWZglKL/J2WDwa0EGXxsHvZHfv1IDnMUAIpPQGLdaGqRH3FwEmVACl9wLh9NjIMUW7J7eKRQYlQfmQBBQUSprlUiw0SrG/Dr4H6i8TFQOCtCcHFEa/lYBjVq5MEElCQpBYX+3MFySK+xYx7Qb60z/uE3C/sRtatLvcji86LSwbZmLoX7tUVZqBXCbv/ND1ZQzlqahCtu7osL8Oc/bSt8+a+7n6iFfLXOMZJc0MZylc1KA4u8Y6qCd9a9melqN1zpNH7chUtX8FWImLCmuOE2pn0cbpkxi4Bx1ST5biAeOZlFdzycxYxui/X91HLTbl00BROLYCzN5S1puvu/eC+aiLcyHK7fdB3g4Fm+Qh76Qrtc3MDhx4xMqPztcvcnaUoQ5T0EBltKVzPK/mOwDiJuHvNtv3Vdfquy8bYMckA05MdSACjQP41UECsz2Gnpmy4xS/zUCqxVk2OGnLCYInqQMqR4rFk4qefJQrRqK9+w2MRis= pacheco@sharingan"
}

resource "local_file" "inventory" {
  filename = "./inventory/hosts.ini"
  content  = <<EOF
[master]
${aws_instance.public[0].public_ip}

[nodes]
${aws_instance.public[1].public_ip}
${aws_instance.public[2].public_ip}

[all:vars]
ansible_user=ec2-user
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
}
