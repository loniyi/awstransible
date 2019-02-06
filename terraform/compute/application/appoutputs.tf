output "app_autoscalinggroup" {
   value = "${aws_autoscaling_group.app_asg.name}"
}

output "app_privateips" {
  value = "${data.aws_instances.app_asg.private_ips}"
}



output "app-private-ips" {
  value = "${data.aws_instance.asg-one-instances.*.private_ip}"
}