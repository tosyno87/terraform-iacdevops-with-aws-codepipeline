# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_id
output "ec2_bastion_instance-id" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}
## ec2_bastion_public_ip
output "ec2_bastion_instance-ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip
}

/*
# Private EC2 Instances for app1
## ec2_private_instance_ids
output "ec2_private_instance_id" {
  description = "List of IDs of private instances"
  #value       = module.ec2_private.id
  value = [for ec2private in module.ec2_private : ec2private.id]
}

## ec2_private_ip
output "ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  #value       = module.ec2_private.ec2_private_ip
  value = [for ec2private in module.ec2_private : ec2private.private_ip]
}

# Private EC2 Instances for app2
## ec2_private_instance_ids
output "ec2_private-app2_instance_id" {
  description = "List of IDs of private instances"
  #value       = module.ec2_private.id
  value = [for ec2private in module.ec2_private_app2 : ec2private.id]
}

## ec2_private_ip
output "ec2_private-app2_ip" {
  description = "List of private IP addresses assigned to the instances"
  #value       = module.ec2_private.ec2_private_ip
  value = [for ec2private in module.ec2_private_app2 : ec2private.private_ip]
}

# App3 - Private EC2 Instances
## ec2_private_instance_ids
output "app3_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for ec2private in module.ec2_private_app3 : ec2private.id]
}
## ec2_private_ip
output "app3_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = [for ec2private in module.ec2_private_app3 : ec2private.private_ip]
}
*/