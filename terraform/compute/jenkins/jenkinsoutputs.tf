
output "jenkins_instanceid" {
  value = "${join(", ", aws_instance.ss_jenkins.*.id)}"
}

output "jenkins_privateip" {
  value = "${join(", ", aws_instance.ss_jenkins.*.private_ip)}"
}
