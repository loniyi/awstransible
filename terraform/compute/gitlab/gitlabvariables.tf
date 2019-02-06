variable "gitlab_keyname" {
  description = "The SSH Key-name for the Gitlab Instance"
  default     = ""
}

variable "gitlab_projectname" {
  description = "The Project Name"
  default     = ""
}

variable "gitlab_instancetype" {
  description = "Gitlab Instance Type"
  default     = ""
}

variable "gitlab_userdata" {
  description = "Gitlab Userdata Bootstrap Script"
  default     = ""
}

variable "gitlab_volumetype" {
  description = "Gitlab Root Volume Type"
  default     = ""
}

variable "gitlab_volumesize" {
  description = "Gitlab Root Volume Size (GB)"
  default     = ""
}

variable "gitlab_subnet" {
   description = "Subnet to Deploy The Gitlab Instance"
   type        = "list"
}

variable "gitlab_securitygroup" {
  description = "The Security Group for the Gitlab"
  type        = "list"
  default     = []
}

variable "gitlab_privateip" {
  description = "The Private IP for the Gitlab Instance"
  default     = ""
}

variable "gitlab_availabilityzone" {
   description = "The Availability Zone to Launch the Instance"
   default     = ""
}

variable "gitlab_instanceami" {
    description = "Gitlab Instance AMI"
    default     = ""
}