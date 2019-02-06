
variable "db_instanceclass" {
  description = "Instance Class of the DB"
  default     = ""
}

variable "db_name" {
  description = "Instance name of the DB"
  default     = ""
}

variable "db_username" {
  description = "Instance Class of the DB"
  default     = ""
}

variable "db_password" {
  description = "Password of the DB"
  default     = ""
}

variable "db_subnetgroup" {
  description = "Subnet Group of the DB"
  default     = ""
}

variable "db_version" {
  description = "Engine version of the DB"
  default     = ""
}

variable "db_engine" {
  description = "Type of Database"
  default     = ""
}

variable "db_allocatedstorage" {
  description = "Allocated Storage of the DB"
  default     = ""
}

variable "db_securitygroup" {
  description = "Security Group of the DB"
  type = "list"
}

variable "db_zone_id" {
  description = "Allocated Secondary Zone of the DB"
  default     = ""
}

variable "domain_name" {
  description = "Domain Name for the DB"
  default     = ""
}