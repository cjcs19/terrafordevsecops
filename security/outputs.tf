## output variables
#output "ecs_machines_security_group_id" {
#  value = aws_security_group.ecs_machines_security_group.id
#}


#output "app_load_balancer_security_group_id" {
#  value = aws_security_group.app_load_balancer_security_group.id
#}

output "ec2_security_group_ssh_id" {
  value = aws_security_group.allow_ssh.id
}

