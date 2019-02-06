
output "rocketchat_instanceid" {
  value = "${join(", ", aws_instance.ss_rocketchat.*.id)}"
}

output "rocketchat_privateip" {
  value = "${join(", ", aws_instance.ss_rocketchat.*.private_ip)}"
}

