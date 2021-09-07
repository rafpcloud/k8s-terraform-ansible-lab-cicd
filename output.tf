

output "public" {
  value = {
    for k, v in aws_instance.public : k => v.public_ip
  }
}
