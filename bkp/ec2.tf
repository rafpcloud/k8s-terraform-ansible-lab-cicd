resource "aws_instance" "master" {
  
  instance_type        = "t3.medium"
  ami                  = "ami-0dc2d3e4c0f9ebd18"
  count                = var.instance_count
  iam_instance_profile = aws_iam_instance_profile.k8s_profile.name
  availability_zone    = lookup(var.availability_zone,var.aws_region)
  key_name             = "ssh-key"
  #security_groups  =   ["sgweb"]
     timeouts {
    create = "10m"
    delete = "20m"
  }

tags = { 
Name= element(var.instance_tags, count.index)

}
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDipaeDQg+h85jU7tCN5wQ6FwbDYtHkB11wjnfMc+vwWipbqXUffFDDdlC0Cst/dNvkAluPfqR6kWwf5WNd5ahn2MMp2i1pBBXqHFBozUcska9sWx52rulNw61eTIX0ZxXQAAKNC1b3H0godwyhLn/CtTEtyF1bfAJcsqMgOJjJGRMZVO5+hgKvZ1xuAH+oTT/vWm9ncSkO4Nj7Zy8+6ozb8vW/TEFqJMebZkk/ZMGsdAoi1480XBp8I1fbcYuBkgETqJTVcM13UtSqYXHfqM5QNvANZ8yRa4B0GEnzyehixZffzmm2eusJEckZTMMcGFH1HVP0qyIFELfb5OvjmiDnJGu8k1XC7W34Bqatv1KYVodZEudGFhVnWW06W36tZ+PXFr1j+XhMdctRZm9HfpfyT5sJnLfN0Y547dzKablGkGDLQZZfq+wfBzUMRXkqgl9Z/i3A6vavQzfs/nzcKhkV1Wk0jPjVTNyR8Q5pC/9nDDxKczDnyUP6B3E6R+f+OU8= pacheco@CPX-PZENE5BQG4O"
}
