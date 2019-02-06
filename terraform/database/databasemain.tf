
resource "aws_db_instance" "ss_database" {
  allocated_storage      = "${var.db_allocatedstorage}"
  engine                 = "${var.db_engine}"
  engine_version         = "${var.db_version}"
  instance_class         = "${var.db_instanceclass}"
  name                   = "${var.db_name}"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  db_subnet_group_name   = "${var.db_subnetgroup}" 
  vpc_security_group_ids = ["${var.db_securitygroup}"]
  skip_final_snapshot    = true
}
