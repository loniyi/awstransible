
output "vault_instanceid" {
  value = "${join(", ", aws_instance.ss_vault.*.id)}"
}

output "vault_privateip" {
  value = "${join(", ", aws_instance.ss_vault.*.private_ip)}"
}
