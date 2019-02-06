#---------------Common Project Variable Inputs
aws_region     = "your_aws_region"
ss_keyname     = "your_ssh_key_name"
aws_profile    = "your_aws_environment_profile"
environment    = "your_environment"
project_name   = "your_project_name"
company_name   = "your_company_name"
public_keypath = "your_public_key_path"


#---------------Networking Variable Inputs------
vpc_cidr               = "10.20.0.0/16"
accessip               = "your_restricted_access_ip/range"
domain_name            = "your_domain_name"
elb_timeout            = "3"
elb_interval           = "30"
#delegation_set         = "your_delegation_set_ID"
elb_healthythreshold   = "2"
elb_unhealthythreshold = "2"

public_cidrs   = [
    "10.20.1.0/24",
    "10.20.2.0/24",
    "10.20.3.0/24"]
private_cidrs  = [
    "10.20.11.0/24",
    "10.20.12.0/24",
    "10.20.13.0/24"]
database_cidrs = [
    "10.20.21.0/24",
    "10.20.22.0/24",
    "10.20.23.0/24"]

#----------------Compute Servers Variable Inputs-------
volume_size       = "your_compute_volume_size"
volume_type       = "gp2"
instance_type     = "t2.micro"
availability_zone = "your_aws_region"

#---BastionHost Server Variable Inputs
bastionhost_minsize          = "1"
bastionhost_maxsize          = "1"
bastionhost_desiredcapacity  = "1"
bastionhost_enablemonitoring = "false"

#---Rocketchat Server Variable Inputs
rocketchat_privateip = "10.20.11.110"


#---Jenkins Server Variable Inputs
jenkins_privateip = "10.20.11.120"


#---Vault Server Variable Inputs
vault_privateip = "10.20.11.130"


#---Gitlab Server Variable Inputs
gitlab_privateip    = "10.20.11.140"
gitlab_instancetype = "t2.medium"


#---Application Server Variables
app_asghct      = "EC2"
app_asggrace    = "300"
app_asgminsize  = "1"   
app_asgmaxsize  = "1"     
app_asgcapacity = "1"


#----------------MySQL Database Variable Inputs-------

db_name		    = "your_database_name"
db_engine	    = "mysql"
db_version	    = "5.7.19"
db_username	    = "your_database_username"
db_password	    = "your_database_password"
db_instanceclass    = "your_data_base_instance-type"
db_allocatedstorage = "5"