# [Terraform - CICD with Ansible]

Terraform AWS Infrastructure with Ansible Deployment for CICD Pipeline

The module deploys infrastructure in Amazon Web Services (AWS), automates the configuration via Ansible, and sets up a CI/CD pipeline for a web application.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [VPC Endpoint](https://www.terraform.io/docs/providers/aws/r/vpc_endpoint.html) (Gateway: S3)
* [RDS DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)
* [DHCP Options Set](https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options.html)

Sponsored by [Cloudcraft - the best way to draw AWS diagrams](https://cloudcraft.co/?utm_source=terraform-aws-vpc)



<a href="https://cloudcraft.co/?utm_source=terraform-aws-vpc" target="_blank"><img src="https://raw.githubusercontent.com/antonbabenko/modules.tf-lambda/master/misc/cloudcraft-logo.png" alt="Cloudcraft - the best way to draw AWS diagrams" width="211" height="56" /></a>

## Preview
**Infrastructure Preview](https://ibb.co/ngVqNRr)**

**[Architecture Stack](https://ibb.co/SJ8gFff)**

<a><img src="https://ibb.co/ngVqNRr" alt="Cloudcraft - the best way to draw AWS diagrams" width="211" height="56" /></a>

### Prerequisites

Install Terraform and Ansible on local system
Have an AWS account (Some infrastructure may inquire some cost.)
Set Environment variables for AWS or Profile


## Download and Installation

To begin using this Terraform script, choose one of the following options to get started:
* Clone the repo: `git clone https://github.com/loniyi/awsterrformansible.git`
* [Fork, Clone, or Download on GitHub](https://github.com/loniyi/awsterrformansible.git)



## Usage

After downloading/cloning, simply edit the terraform.tfvars file included  in the root folder and run terraform init and terraform apply.

```hcl
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
```

### Notes

## EIPs

By default this module will provision new Elastic IPs for the VPC's NAT Gateways and the BastionHost
This means that when creating a new VPC, new IPs are allocated, and when that VPC is destroyed those IPs are released.

## Delegation Set for Route53
Regarding the delegation set variable, you can create a delegation set prior to using the script and include the set ID, while making sure you uncomment the delegation_set variable in the route53 resource in the networkingmain.tf file. If you want to create a new delegation set, just uncomment the delegation_set resource in the networkingmain.tf file.

To achieve this, create the reusable delegation set using aws cli.
```hcl
aws route53 create-reusable-delegation-set --caller-reference 1224 --profile "your_aws_profile"
```

Then, pass the allocated delegation_set_id as a parameter to this module.
```hcl
#----Primary Zone
resource "aws_route53_zone" "ss_primaryzone" {
  name              = "${var.domain_name}.com"
  delegation_set_id = "N35M7*********"
  #delegation_set_id = "${aws_route53_delegation_set.ss_dns.id}"
}
```

Otherwise to create and use a new delegation set, uncomment the delegation_set resource and the first delegation_set_id in the Primary Zone sectio, and comment out the second delegation_set_id.
```hcl

/*
#----Delegation Set
resource "aws_route53_delegation_set" "ss_dns" {
  reference_name = "${var.nt_projectname}"
}
*/
```

Then, in the networking folder, in the networkingmain.tf file uncomment the delegation_set outputs.
```hcl
/*
output "delegation_setid" {
   value = "${aws_route53_delegation_set.ss_dns.id}"
}

output "delegation_nameservers" {
   value = "${aws_route53_delegation_set.ss_dns.name_servers}"
}
*/
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## IMPORTANT Outputs

| Name | Description |
|------|-------------|
| BastionHost EIP Address | The EIP of the BastionHost |
| Database Subnets | List of IDs of Database Subnets |
| Delegation Name Servers | List of NS Records |
| Delegation Set Id | The Delegation Set ID  |
| Gitlab Server Private IP Address | The Private IP Address for the GitLab Server |
| Jenkins Server Private IP address| The Private IP Address for the Jenkins Server |
| Nat Gateway EIP | The EIP of the Nat Gateway |
| Private Subnets | List of IDs of Private Subnets |
| Public Subnets | List of IDs of Public Subnets |
| RocketChat Server Private IP address | The Private IP Address for the Rocketchat Server |
| S3 Bucket Name | The S3 Bucket Name |
| Vault Server Private IP Address | The Private IP Address for the Vault Server |
| VPC ID | The VPC ID |
| WebApp Private Ips | The Private IP Addresses for the Web Servers |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Ansible Configuration

This Ansible playbook supports roles for the installation and configuration of the following servers.

* JENKINS
    * `Java`
    * `ChefInspec`
    * `Maven`
    * `Git`
* VAULT
* GITLAB
* ROCKETCHAT
* BASTIONHOST
* WEBAPP
    * `ChefInspec`
    * `SSH`

## Usage

To run the playbook properly, edit the inventory and ssh.cfg file and input the Bastionhost EIP from the output of the terraform script. Include the public key path. Also ssh-add your key to the ssh-agent. Finally get the private IP of your webapp server from the terraform output and insert in the inventory file.

Run 'ansible-playbook install.yml' from the ansible directory.

## Authors

Module is maintained by [loniyi] with help from [Elliot Holden](https://gitlab.com/elliotholden).

## License

Apache 2 Licensed. See LICENSE for full details.
