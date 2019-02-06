#----------Common Project Variables
variable "aws_region" {}
variable "ss_keyname" {} 
variable "aws_profile" {}
variable "environment" {}
variable "project_name" {}
variable "company_name" {}
variable "public_keypath" {}

#----------Networking variables
variable "vpc_cidr" {}
variable "accessip" {}
variable "domain_name" {}
variable "elb_timeout" {}
variable "elb_interval" {}
#variable "delegation_set" {}
variable "elb_unhealthythreshold" {}
variable "elb_healthythreshold" {}

variable "private_cidrs" {
  type = "list"}
variable "public_cidrs" {
  type = "list"}
variable "database_cidrs" {
  type = "list"}

#------------Compute Variables------
#------Common Compute Variables
variable "volume_size" {}
variable "volume_type" {}
variable "instance_type" {}
variable "availability_zone" {}

#------BastionHost Server Variables
variable "bastionhost_minsize" {}
variable "bastionhost_maxsize" {}
variable "bastionhost_desiredcapacity" {}
variable "bastionhost_enablemonitoring" {}

#------RocketChat Server Variables           
variable "rocketchat_privateip" {}      
    
#------Jenkins Server Variables          
variable "jenkins_privateip" {}      

#------Vault Server Variables           
variable "vault_privateip" {}      

#------Gitlab Server Variables          
variable "gitlab_privateip" {}           
variable "gitlab_instancetype" {}   

#------Applications Server Variables
variable "app_asghct" {}
variable "app_asggrace" {}
variable "app_asgminsize" {}   
variable "app_asgmaxsize" {}       
variable "app_asgcapacity" {}


#------Database Server Variables          
variable "db_name" {} 
variable "db_engine" {}      
variable "db_version" {}     
variable "db_password" {}    
variable "db_username" {}         
variable "db_instanceclass" {}     
variable "db_allocatedstorage" {}  

