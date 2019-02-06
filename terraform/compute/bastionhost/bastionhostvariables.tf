variable "bastionhost_projectname" {
  description = "The Project Name"
  default     = ""
}

variable "bastionhost_region" {
  description = "Region to Deploy the Bastion Host"
  default     = ""
}

variable "bastionhost_instancetype" {
  description = "Bastion instance type"
  default     = ""
}

variable "bastionhost_keyname" {
  description = "Bastion SSH key pair name"
  default     = ""
}

variable "bastionhost_securitygroup" {
  description = "Bastion security group list"
  type        = "list"
  default     = []
}

variable "bastionhost_enablemonitoring" {
  description = "Bastion enable detailed monitoring (true/false)"
  default     = ""
}

variable "bastionhost_maxsize" {
  description = "Bastion ASG maximum size"
  default     = ""
}

variable "bastionhost_minsize" {
  description = "Bastion ASG minimum size"
  default     = ""
}

variable "bastionhost_desiredcapacity" {
  description = "Bastion ASG desired size"
  default     = ""
}

variable "bastionhost_asgsubnets" {
   description = "Bastion ASG desired size"
   type = "list"
   default     = []
}

variable "bastionhost_instanceami" {
    description = "BastionHost AMI"
    default     = ""
}