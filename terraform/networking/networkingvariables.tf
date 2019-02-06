#------networking/variables.tf

variable "accessip" {}
variable "vpc_cidr" {}
variable "aws_region" {}
variable "ss_keyname" {}
variable "domain_name" {}
variable "environment" {}
variable "elb_timeout" {}
variable "company_name" {}
variable "elb_interval" {}
variable "nt_projectname" {}
variable "public_keypath" {}
#variable "delegation_set" {}
#variable "vault_instance" {}
variable "gitlab_instance" {}
variable "jenkins_instance" {}
variable "database_instance" {}
variable "rocketchat_instance" {}
variable "elb_healthythreshold" {}
variable "elb_unhealthythreshold" {}
variable "bastionhost_eipaddress" {}


variable "public_cidrs" {
  type = "list"
}

variable "private_cidrs" {
  type = "list"
}
 
variable "database_cidrs" {
  type = "list"
}