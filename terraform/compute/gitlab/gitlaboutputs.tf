output "gitlab_instanceid" {
  value = "${join(", ", aws_instance.ss_gitlab.*.id)}"
}

output "gitlab_privateip" {
  value = "${join(", ", aws_instance.ss_gitlab.*.private_ip)}"
}
