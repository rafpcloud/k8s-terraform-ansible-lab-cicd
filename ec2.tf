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

 Name = each.key == "0" ? "MASTER" : "WORKER${each.key}" 
 Type = each.key == "0" ? "MASTER" : "WORKER"
 Infra = "K8S"

  }

lifecycle {
    ignore_changes = [
     
      tags
    ]
  }

}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = ""
}
