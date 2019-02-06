
#---Instance AMI Output
output "instance_ami" {
  description = "Instance AMI Image ID"
  value       = "${data.aws_ami.instance_ami.image_id}"
}

#---Application User Data Output
output "app_userdata" {
  description = "Instance AMI Image ID"
  value       = "${data.template_file.compute_appuserdata.rendered}"
}



#---DevOps User Data Output
output "devops_userdata" {
  description = "Instance AMI Image ID"
  value       = "${data.template_file.compute_devopsuserdata.rendered}"
}




#---Bastionhost Output
output "bastionhost_eipaddress" {
  description = "List of Bastion Host EIP"
  value       = "${module.bastion.bastionhost_eipaddress}"
}
#---RocketChat Outputs
output "rocketchat_instanceid" {
  description = "Rocketchat Server Instance ID"
  value       = "${module.rocketchat.rocketchat_instanceid}"
}

output "rocketchat_privateip" {
  description = "Rocketchat Server Instance IP"
  value       = "${module.rocketchat.rocketchat_privateip}"
}

#---Jenkins Outputs
output "jenkins_instanceid" {
  description = "Jenkins Server Instance ID"
  value       = "${module.jenkins.jenkins_instanceid}"
}

output "jenkins_privateip" {
  description = "Jenkins Server Instance ID"
  value       = "${module.jenkins.jenkins_privateip}"
}

#---Vault Outputs
output "vault_instanceid" {
  description = "Vault Server Instance ID"
  value       = "${module.vault.vault_instanceid}"
}

output "vault_privateip" {
  description = "Vault Server Instance ID"
  value       = "${module.vault.vault_privateip}"
}

#---Gitlab Outputs
output "gitlab_instanceid" {
  description = "Gitlab Server Instance ID"
  value       = "${module.gitlab.gitlab_instanceid}"
}

output "gitlab_privateip" {
  description = "Gitlab Server Instance ID"
  value       = "${module.gitlab.gitlab_privateip}"
}


#---Application Outputs
output "app_autoscalinggroup" {
   value = "${module.application.app_autoscalinggroup}"
}


output "app_privateips" {
  value = "${module.application.app_privateips}"
}

output "app-private-ips" {
  value = "${module.application.app-private-ips}"
}

