output "database_instanceid" {
  value = "${aws_db_instance.ss_database.address}"
 }