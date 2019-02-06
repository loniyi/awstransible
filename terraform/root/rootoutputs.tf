
#---Networking Outputs -----
/*
output "Delegation Set Id" {
   value = "${module.networking.delegation_setid}"
} 
 
output "Delegation Name Servers" {
   value = "${module.networking.delegation_nameservers}"
}
*/
output "Private Subnets" {
  description = "List of IDs of Application Subnets"
  value       = "${join(", ", module.networking.private_subnets)}"
}

output "Public Subnets" {
  description = "List of IDs of Public Subnets"
  value       = "${join(", ", module.networking.public_subnets)}"
}

output "Database Subnets" {
  description = "List of IDs of Database Subnets"
  value       = "${join(", ", module.networking.database_subnets)}"
}

output "Public Subnet IP Addresses" {
  description = "List of Public Subnet IP Addresses"
  value       = "${join(", ", module.networking.subnet_ips)}"
}

output "Private Subnet IP Addresses" {
  description = "List of IDs of Application Subnets IP Address"
  value       = "${join(", ", module.networking.psubnet_ips)}"
}

output "Database Subnet IP Addresses" {
  description = "List of IDs of Subnets IP Address"
  value       = "${join(", ", module.networking.dsubnet_ips)}"
}

output "Public Security Group ID" {
  description = "ID of Public Security Groups"
  value       = "${module.networking.public_sg}"
}

output "Private Security Group ID" {
  description = "ID of Application Security Groups"
  value       = "${module.networking.private_sg}"
}

output "Database Security Group ID" {
  description = "ID of Database Security Groups"
  value       = "${module.networking.database_sg}"
}

output "VPC ID" {
  description = "List of VPC ID"
  value       = "${module.networking.vpc_id}"
}


output "Nat Gateway EIP" {
  description = "List of Bastion Host EIP"
  value       = "${module.networking.natgateway_eip}"
}



#------------Compute Outputs ------
#---Bastionhost Outputs

output "BastionHost EIP Address" {
  description = "List of Bastion Host EIP"
  value       = "${module.compute.bastionhost_eipaddress}"
}


#----Rocketchat Outputs
output "RocketChat Server ID" {
  description = "Instance ID for Rocketchat"
  value       = "${module.compute.rocketchat_instanceid}"
}

output "RocketChat Server Private IP address" {
  description = "Private IP Address for Rocketchat"
  value       = "${module.compute.rocketchat_privateip}"
}

#----Jenkins Outputs
output "Jenkins Server ID" {
  description = "Instance ID for Jenkins"
  value       = "${module.compute.jenkins_instanceid}"
}

output "Jenkins Server Private IP address" {
  description = "Private IP Address for jenkins"
  value       = "${module.compute.jenkins_privateip}"
}

#----Vault Outputs
output "Vault Server ID" {
  description = "Instance ID for Vault"
  value       = "${module.compute.vault_instanceid}"
}

output "Vault Server Private IP Address" {
  description = "Private IP Address for Vault"
  value       = "${module.compute.vault_privateip}"
}

#----Gitlab Outputs
output "Gitlab Server ID" {
  description = "Instance ID for Gitlab"
  value       = "${module.compute.gitlab_instanceid}"
}

output "Gitlab Server Private IP Address" {
  description = "Private IP Address for Gitlab"
  value       = "${module.compute.gitlab_privateip}"
}

#----Storage Outputs------
output "S3 Bucket Name" {
  description = "Name of Bucket"
  value       = "${module.storage.s3_bucketname}"
}





output "WebApp Private Ips" {
  value = "${module.compute.app_privateips}"
}

output "app-private-ips" {
  value = "${module.compute.app-private-ips}"
}
