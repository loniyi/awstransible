
variable "vault_keyname" {
  description = "The SSH Key-name for the vault Instance"
  default     = ""
}

variable "vault_projectname" {
  description = "The Project Name"
  default     = ""
}

variable "vault_instancetype" {
  description = "vault Instance Type"
  default     = ""
}

variable "vault_userdata" {
  description = "vault Userdata Bootstrap Script"
  default     = ""
}

variable "vault_volumetype" {
  description = "vault Root Volume Type"
  default     = ""
}

variable "vault_volumesize" {
  description = "vault Root Volume Size (GB)"
  default     = ""
}

variable "vault_subnet" {
   description = "Subnet to Deploy The vault Instance"
   type        = "list"
}

variable "vault_securitygroup" {
  description = "The Security Group for the vault"
  type        = "list"
  default     = []
}

variable "vault_privateip" {
  description = "The Private IP for the vault Instance"
  default     = ""
}

variable "vault_availabilityzone" {
   description = "The Availability Zone to Launch the Instance"
   default     = ""
}

variable "vault_instanceami" {
    description = "vault Instance AMI"
    default     = ""
}