

# ----Deploy BastionHost Server---
module "bastion" {
  source                   = "./bastionhost"
  bastionhost_region           = "${var.bastionhost_region}"
  bastionhost_keyname          = "${var.ssh_keyname}" 
  bastionhost_minsize          = "${var.bastionhost_minsize}" 
  bastionhost_maxsize          = "${var.bastionhost_maxsize}"      
  bastionhost_asgsubnets       = ["${var.public_subnets}"]
  bastionhost_projectname      = "${var.project_name}"   
  bastionhost_instanceami      = "${var.instance_ami}"
  bastionhost_instancetype     = "${var.instance_type}"  
  bastionhost_securitygroup    = ["${var.bastionhost_securitygroup}"] 
  bastionhost_desiredcapacity  = "${var.bastionhost_desiredcapacity}"
  bastionhost_enablemonitoring = "${var.bastionhost_enablemonitoring}"
 }


# ----Deploy Rocketchat Server----
module "rocketchat" {
  source                      = "./rocketchat" 
  rocketchat_subnet          = "${var.private_subnets}"
  rocketchat_keyname          = "${var.ssh_keyname}"  
  rocketchat_userdata         = "${var.devops_userdata}" 
  rocketchat_privateip        = "${var.rocketchat_privateip}"
  rocketchat_volumesize       = "${var.volume_size}"
  rocketchat_volumetype       = "${var.volume_type}"   
  rocketchat_projectname      = "${var.project_name}"  
  rocketchat_instanceami      = "${var.instance_ami}"
  rocketchat_instancetype     = "${var.instance_type}"
  rocketchat_securitygroup    = ["${var.private_securitygroup}"] 
  rocketchat_availabilityzone = "${var.availability_zone}"
 }


# ----Deploy Jenkins Server----
module "jenkins" {
  source                   = "./jenkins"  
  jenkins_subnet           = "${var.private_subnets}"  
  jenkins_keyname          = "${var.ssh_keyname}"   
  jenkins_userdata         = "${var.devops_userdata}"  
  jenkins_privateip        = "${var.jenkins_privateip}"
  jenkins_volumesize       = "${var.volume_size}"
  jenkins_volumetype       = "${var.volume_type}"
  jenkins_projectname      = "${var.project_name}" 
  jenkins_instanceami      = "${var.instance_ami}"
  jenkins_instancetype     = "${var.instance_type}"
  jenkins_securitygroup    = ["${var.private_securitygroup}"]
  jenkins_availabilityzone = "${var.availability_zone}" 
 }

# ----Deploy Vault Server----
module "vault" {
  source                 = "./vault" 
  vault_subnet           = "${var.private_subnets}" 
  vault_keyname          = "${var.ssh_keyname}"   
  vault_userdata         = "${var.devops_userdata}"  
  vault_privateip        = "${var.vault_privateip}"
  vault_volumesize       = "${var.volume_size}"
  vault_volumetype       = "${var.volume_type}"
  vault_projectname      = "${var.project_name}"  
  vault_instanceami      = "${var.instance_ami}"
  vault_instancetype     = "${var.instance_type}"
  vault_securitygroup    = ["${var.private_securitygroup}"] 
  vault_availabilityzone = "${var.availability_zone}"
 }


# ----Deploy Gitlab Server----
module "gitlab" {
  source                  = "./gitlab" 
  gitlab_subnet           = "${var.private_subnets}" 
  gitlab_keyname          = "${var.ssh_keyname}" 
  gitlab_userdata         = "${var.devops_userdata}" 
  gitlab_privateip        = "${var.gitlab_privateip}"
  gitlab_volumesize       = "${var.volume_size}"
  gitlab_volumetype       = "${var.volume_type}"
  gitlab_projectname      = "${var.project_name}"
  gitlab_instanceami      = "${var.instance_ami}"
  gitlab_instancetype     = "${var.gitlab_instancetype}"
  gitlab_securitygroup    = ["${var.private_securitygroup}"] 
  gitlab_availabilityzone = "${var.availability_zone}"
 }


# ----Deploy Application Server----
module "application" {
  source               = "./application" 
  app_asghct           = "${var.app_asghct}" 
  app_keyname          = "${var.ssh_keyname}"
  app_userdata         = "${var.app_userdata}"
  app_asggrace         = "${var.app_asggrace}"
  app_asgminsize       = "${var.app_asgminsize}" 
  app_asgmaxsize       = "${var.app_asgmaxsize}"
  app_asgsubnets       = ["${var.private_subnets}"] 
  app_projectname      = "${var.project_name}"
  app_asgcapacity      = "${var.app_asgcapacity}"
  app_instanceami      = "${var.instance_ami}"
  app_instancetype     = "${var.instance_type}"
  app_loadbalancers    = ["${var.app_loadbalancers}"]
  app_instanceprofile  = "${var.app_instanceprofile}"
  app_lcsecuritygroups = ["${var.private_securitygroup}"]   
 }

