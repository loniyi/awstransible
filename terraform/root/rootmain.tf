provider "aws" {
  region  = "${var.aws_region}"
  version = "~> 1.54"
  profile = "${var.aws_profile}"
}


# ---Deploy NetWorking Resources---
module "networking" {
  source                 = "../networking"
  accessip               = "${var.accessip}"
  vpc_cidr               = "${var.vpc_cidr}"
  aws_region             = "${var.aws_region}"
  ss_keyname             = "${var.ss_keyname}"
  domain_name            = "${var.domain_name}"
  environment            = "${var.environment}"
  elb_timeout            = "${var.elb_timeout}"
  public_cidrs           = "${var.public_cidrs}"
  company_name           = "${var.company_name}" 
  elb_interval           = "${var.elb_interval}"
  nt_projectname         = "${var.project_name}"
  private_cidrs          = "${var.private_cidrs}"
  database_cidrs         = "${var.database_cidrs}"
  public_keypath         = "${var.public_keypath}"
  #delegation_set        = "${var.delegation_set}"
  gitlab_instance        = "${module.compute.gitlab_instanceid}"
  jenkins_instance       = "${module.compute.jenkins_instanceid}"
  database_instance      = "${module.database.database_instanceid}"
  rocketchat_instance    = "${module.compute.rocketchat_instanceid}"
  elb_healthythreshold   = "${var.elb_healthythreshold}"
  elb_unhealthythreshold = "${var.elb_unhealthythreshold}"
  bastionhost_eipaddress = "${module.compute.bastionhost_eipaddress}"
 } 
  

# ----Deploy Compute Resources----
module "compute" {
  source          = "../compute"
  #--- Common Variables
  volume_size           = "${var.volume_size}"
  volume_type           = "${var.volume_type}"
  ssh_keyname           = "${module.networking.ssh_keyname}"
  project_name          = "${var.project_name}"
  instance_ami          = "${module.compute.instance_ami}"
  instance_type         = "${var.instance_type}"
  public_subnets        = "${module.networking.public_subnets}"
  private_subnets       = "${module.networking.private_subnets}"
  devops_userdata       = "${module.compute.devops_userdata}"
  availability_zone     = "${var.availability_zone}"
  public_securitygroup  = ["${module.networking.public_sg}"]
  private_securitygroup = ["${module.networking.private_sg}"]

 
  #------BastionHost
  bastionhost_region           = "${var.aws_region}" 
  bastionhost_minsize          = "${var.bastionhost_minsize}"
  bastionhost_maxsize          = "${var.bastionhost_maxsize}"
  bastionhost_securitygroup    = "${module.networking.bastionhost_sg}"  
  bastionhost_desiredcapacity  = "${var.bastionhost_desiredcapacity}"
  bastionhost_enablemonitoring = "${var.bastionhost_enablemonitoring}"

  #-----Vault  
  vault_privateip = "${var.vault_privateip}"   

  #-----Jenkins  
  jenkins_privateip = "${var.jenkins_privateip}"      

  #-----Gitlab 
  gitlab_privateip     = "${var.gitlab_privateip}"      
  gitlab_instancetype  = "${var.gitlab_instancetype}"

  #-----Rocketchat
  rocketchat_privateip = "${var.rocketchat_privateip}"

  #-----Application
  app_asghct                   = "${var.app_asghct}"
  app_asggrace                 = "${var.app_asggrace}"
  app_userdata                 = "${module.compute.app_userdata}"
  app_asgminsize               = "${var.app_asgminsize}" 
  app_asgmaxsize               = "${var.app_asgmaxsize}"
  app_asgcapacity              = "${var.app_asgcapacity}"
  app_loadbalancers            = "${module.networking.application_loadbalancer}"
  app_instanceprofile          = "${module.storage.app_s3instanceprofile}"

 }

#----Database Resources----
module "database" {
  source              = "../database"  
  db_name             = "${var.db_name}"
  db_engine           = "${var.db_engine}"
  db_version          = "${var.db_version}"
  db_zone_id          = "${module.networking.secondary_zone}"
  db_password         = "${var.db_password}"
  db_username         = "${var.db_username}"
  db_subnetgroup      = "${module.networking.database_subnetgroup}"
  db_securitygroup    = ["${module.networking.database_sg}"]
  db_instanceclass    = "${var.db_instanceclass}"
  db_allocatedstorage = "${var.db_allocatedstorage}" 
 }

# ---Deploy Storage Resource---
module "storage" {
  source         = "../storage"
  s3_projectname = "${var.project_name}"
}
