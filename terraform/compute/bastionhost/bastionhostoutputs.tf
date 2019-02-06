output "bastionhost_eipaddress" {
  description = "The Bastion's public elastic IP address"
  value       = "${aws_eip.bastionhost_eipaddress.public_ip}"
}

