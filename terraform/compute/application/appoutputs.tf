

output "app_privateips" {
  value = "${data.aws_instance.asg_instances.*.private_ip}"
}