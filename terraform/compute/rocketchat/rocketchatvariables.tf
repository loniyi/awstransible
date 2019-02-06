

variable "rocketchat_keyname" {
  description = "SSH Keyname"
  default     = ""
}

variable "rocketchat_projectname" {
  description = "The name of the customer"
  default     = ""
}

variable "rocketchat_instancetype" {
  description = "rocketchat instance type"
  default     = ""
}

variable "rocketchat_userdata" {
  description = "rocketchat user data bootstrap script"
  default     = ""
}

variable "rocketchat_volumetype" {
  description = "rocketchat root volume type"
  default     = ""
}

variable "rocketchat_volumesize" {
  description = "rocketchat root volume size (GB)"
  default     = ""
}

variable "rocketchat_instanceami" {
   description = "rocketchat desired size"
   default     = ""
}


variable "rocketchat_subnet" {
   description = "rocketchat desired subnet"
   type        = "list"
}

variable "rocketchat_securitygroup" {
  description = "rocketchat security group list"
  type        = "list"
  default     = []
}

variable "rocketchat_privateip" {
  description = "rocketchat security group list"
  default     = ""
}

variable "rocketchat_availabilityzone" {
   description = "availability zone to launch instance"
   default     = ""
}

