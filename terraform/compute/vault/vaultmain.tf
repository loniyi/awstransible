
# ---------------------------------------
# Vault Instance
# ---------------------------------------  

resource "aws_instance" "ss_vault" {
  ami                    = "${var.vault_instanceami}"
  key_name               = "${var.vault_keyname}"
  subnet_id             = "${element(var.vault_subnet, count.index)}"
  user_data              = "${var.vault_userdata}"  
  private_ip             = "${var.vault_privateip}"
  instance_type          = "${var.vault_instancetype}"
  availability_zone      = "${var.vault_availabilityzone}"
  vpc_security_group_ids = ["${var.vault_securitygroup}"]
  
  root_block_device {
      volume_size = "${var.vault_volumesize}"
      volume_type = "${var.vault_volumetype}"
    }

  tags {
    Name = "${var.vault_projectname}_Vault-${count.index +1}"
  }

}



