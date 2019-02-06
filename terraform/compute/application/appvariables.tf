variable "app_projectname" {
  description = "project name"
  default     = ""
}

variable "app_instanceami" {
  description = "app instance ami"
  default     = ""
}

variable "app_instancetype" {
  description = "app instance type"
  default     = ""
}

variable "app_lcsecuritygroups" {
  description = "Launch Configuration Security Group List"
  type        = "list"
  default     = []
}

variable "app_instanceprofile" {
  description = "The development environment (dev, test, prod...)"
  default     = ""
}

variable "app_userdata" {
  description = "app user data bootstrap script"
  default     = ""
}

variable "app_keyname" {
  description = "SSH Key Name"
  default     = ""
} 

variable "app_asgmaxsize" {
  description = "app ASG maximum size"
  default     = ""
}

variable "app_asgminsize" {
  description = "app ASG minimum size"
  default     = ""
}

variable "app_asggrace" {
  description = "ELB Grace Period"
  default     = ""
}

variable "app_asghct" {
  description = "Autoscaling Group Health Check type"
  default     = ""
}

variable "app_asgcapacity" {
  description = "app ASG desired size"
  default     = ""
}

variable "app_loadbalancers" {
  description = "Application ASG Load Balancer list"
  type        = "list"
  default     = []
}

variable "app_asgsubnets" {
   description = "Application ASG Subnets"
   type = "list"
   default     = []
}