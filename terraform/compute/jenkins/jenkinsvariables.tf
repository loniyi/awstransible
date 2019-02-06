
variable "jenkins_keyname" {
  description = "The SSH Key-name for the jenkins Instance"
  default     = ""
}

variable "jenkins_projectname" {
  description = "The Project Name"
  default     = ""
}

variable "jenkins_instancetype" {
  description = "jenkins Instance Type"
  default     = ""
}

variable "jenkins_userdata" {
  description = "jenkins Userdata Bootstrap Script"
  default     = ""
}

variable "jenkins_volumetype" {
  description = "jenkins Root Volume Type"
  default     = ""
}

variable "jenkins_volumesize" {
  description = "jenkins Root Volume Size (GB)"
  default     = ""
}

variable "jenkins_subnet" {
   description = "Subnet to Deploy The jenkins Instance"
   type        = "list"
}

variable "jenkins_securitygroup" {
  description = "The Security Group for the jenkins"
  type        = "list"
  default     = []
}

variable "jenkins_privateip" {
  description = "The Private IP for the jenkins Instance"
  default     = ""
}

variable "jenkins_availabilityzone" {
   description = "The Availability Zone to Launch the Instance"
   default     = ""
}

variable "jenkins_instanceami" {
    description = "jenkins Instance AMI"
    default     = ""
}