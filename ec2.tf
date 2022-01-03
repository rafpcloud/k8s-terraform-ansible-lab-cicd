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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKJAShkZ1/PybZ05+X20bwsNQtNb0oOmFPP9jYBTa1J4nxZp3P1raovaNWe7tSSeTVy3c4eEIXstYmR6NY4uGB4Ku1YbWb6hpsjFioIrZOLK/X/yzF1UP17XoZWJhfCCYLlQuEBcKZvxgxAGA57VPUrve7BO4fTwjVb23TVkC5LNlqT+MMsrSWmgk5oMpHAhpsAoBbXfNMry6lVm4FUxfAKH1EP5a/2UUyF6FUGi4PScw0a8w+Vi1DIKZbgBmz64jxCw3e046WrtA6ASHswrwQ1m5nT+3cBCiq91f8//WNHZhUa7HcSWbLRAn+QqHezA3iHCYD8jAo5MTrDiKiLVGMsdzimRaVs1/QB/3QJAIN2KsNof/X0oZWbHQ9/co/WKJKf+9BrKhG+VvjxpgDXnjhIyhIg/68t+RXs1TiKmI9g+K62EkuSvtlJTDWd8LmBuhX2IdNNMfLNkqw3qrjwv0CC/S78R9Ge337kMs/Zr1l7M4lNAj61fdVTCdYxeDaqps= pacheco@CPX-64JJT2UWWDZ"
}

resource "local_file" "inventory" {
  filename = "./inventory/hosts.ini"
  content  = <<EOF
[defaults]
host_key_checking = False

[master]
${aws_instance.public[0].public_ip}

[nodes]
${aws_instance.public[1].public_ip}
${aws_instance.public[2].public_ip}
[all:vars]
ansible_ssh_user = ec2-user
enable_plugins = aws_ec2

EOF
}
