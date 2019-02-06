/*
output "delegation_setid" {
   value = "${aws_route53_delegation_set.ss_dns.id}"
} 

output "delegation_nameservers" {
   value = "${aws_route53_delegation_set.ss_dns.name_servers}"
} 
*/

output "bastionhost_fqdnname" {
  description = "The Bastion's fully qualified domain name"
  value       = "${aws_route53_record.ss_bastionhost.fqdn}"
}

output "application_loadbalancer" {
  value = "${aws_elb.ss_applicationelb.id}"
}

output "vpc_id" {
  value       = "${aws_vpc.ss_vpc.*.id}"
}

output "natgateway_eip" {
  description = "The VPC NAT Gateway's public elastic IP address"
  value       = "${aws_eip.ss_natgatewayeip.public_ip}"
}

output "public_subnets" {
  value = "${aws_subnet.ss_publicsubnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.ss_privatesubnet.*.id}"
}

output "database_subnets" {
  value = "${aws_subnet.ss_databasesubnet.*.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.ss_publicsubnet.*.cidr_block}"
}

output "psubnet_ips" {
  value = "${aws_subnet.ss_privatesubnet.*.cidr_block}"
}

output "dsubnet_ips" {
  value = "${aws_subnet.ss_databasesubnet.*.cidr_block}"
}

output "public_sg" {
  value = "${aws_security_group.ss_publicsg.id}"
}

output "private_sg" {
  value = "${aws_security_group.ss_privatesg.id}"
}

output "database_sg" {
  value = "${aws_security_group.ss_databasesg.id}"
}

output "bastionhost_sg" {
  value = "${aws_security_group.ss_bastionhostsg.id}"
}

output "database_subnetgroup" {
 value =  "${aws_db_subnet_group.ss_dbsubnetgroup.name}"
}

output "primary_zone" {
 value =  "${aws_route53_zone.ss_primaryzone.zone_id}"
}

output "secondary_zone" {
 value =  "${aws_route53_zone.ss_secondaryzone.zone_id}"
}

output "ssh_keyname" {
 value =  "${aws_key_pair.ss_auth.key_name}"
}

