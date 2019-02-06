# [Terraform - CICD with Ansible]

Terraform AWS Infrastructure with Ansible Deployment for CICD Pipeline

The module deploys infrastructure in Amazon Web Services (AWS), automates the configuration via Ansible, and sets up a CI/CD pipeline for a web application.

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
