
#------Common Variables
variable "volume_size" {}
variable "volume_type" {}
variable "ssh_keyname" {}
variable "project_name" {}
variable "instance_ami" {}
variable "instance_type" {}
variable "devops_userdata" {}
variable "availability_zone" {}


variable "public_subnets" {
  type = "list"
}
variable "private_subnets" { 
  type = "list"
}
variable "public_securitygroup" {
  type = "list"
}
variable "private_securitygroup" {
   type = "list"
}

#------BastionHost Variables
variable "bastionhost_region" {}
variable "bastionhost_minsize" {}
variable "bastionhost_maxsize" {}
variable "bastionhost_securitygroup" {}
variable "bastionhost_desiredcapacity" {}
variable "bastionhost_enablemonitoring" {}

#------RocketChat Variables              
variable "rocketchat_privateip" {}   

#------Jenkins Variables             
variable "jenkins_privateip" {}  

#------Vault Variables              
variable "vault_privateip" {}   

#------Gitlab Variables             
variable "gitlab_privateip" {}     
variable "gitlab_instancetype" {} 


#------Application Variables           
variable "app_asghct" {}
variable "app_userdata" {}
variable "app_asggrace" {}
variable "app_asgminsize" {}   
variable "app_asgmaxsize" {}         
variable "app_asgcapacity" {}
variable "app_loadbalancers" {}
variable "app_instanceprofile" {}

