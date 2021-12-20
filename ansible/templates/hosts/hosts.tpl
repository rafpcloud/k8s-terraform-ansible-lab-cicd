[master]
${k8s_master_name}


[all:vars]
ansible_ssh_private_key_file = ${key_path}
ansible_ssh_user = ec2-user
