data "aws_ami" "amazonlinux_ami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}



resource "aws_instance" "public" {
  for_each      = aws_subnet.public
  ami           = data.aws_ami.amazonlinux_ami.id 
  instance_type = "t2.medium"
  key_name      = aws_key_pair.ssh-key.key_name
  subnet_id     = each.value.id
  
tags = {
  
Name = each.key == [3] ? "MASTER${each.key}" : "NODE${each.key}" 
 
  }

#tags = {
#      Name = Server "${each.key}"
#  }


}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDipaeDQg+h85jU7tCN5wQ6FwbDYtHkB11wjnfMc+vwWipbqXUffFDDdlC0Cst/dNvkAluPfqR6kWwf5WNd5ahn2MMp2i1pBBXqHFBozUcska9sWx52rulNw61eTIX0ZxXQAAKNC1b3H0godwyhLn/CtTEtyF1bfAJcsqMgOJjJGRMZVO5+hgKvZ1xuAH+oTT/vWm9ncSkO4Nj7Zy8+6ozb8vW/TEFqJMebZkk/ZMGsdAoi1480XBp8I1fbcYuBkgETqJTVcM13UtSqYXHfqM5QNvANZ8yRa4B0GEnzyehixZffzmm2eusJEckZTMMcGFH1HVP0qyIFELfb5OvjmiDnJGu8k1XC7W34Bqatv1KYVodZEudGFhVnWW06W36tZ+PXFr1j+XhMdctRZm9HfpfyT5sJnLfN0Y547dzKablGkGDLQZZfq+wfBzUMRXkqgl9Z/i3A6vavQzfs/nzcKhkV1Wk0jPjVTNyR8Q5pC/9nDDxKczDnyUP6B3E6R+f+OU8= pacheco@CPX-PZENE5BQG4O"
}

