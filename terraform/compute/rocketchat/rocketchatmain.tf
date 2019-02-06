
# ---------------------------------------
# Rocketchat Instance
# ---------------------------------------  

resource "aws_instance" "ss_rocketchat" {
  ami                    = "${var.rocketchat_instanceami}"
  key_name               = "${var.rocketchat_keyname}"
  subnet_id             = "${element(var.rocketchat_subnet, count.index)}"
  user_data              = "${var.rocketchat_userdata}"  
  private_ip             = "${var.rocketchat_privateip}"
  instance_type          = "${var.rocketchat_instancetype}"
  availability_zone      = "${var.rocketchat_availabilityzone}"
  vpc_security_group_ids = ["${var.rocketchat_securitygroup}"]
  
  root_block_device {
      volume_size = "${var.rocketchat_volumesize}"
      volume_type = "${var.rocketchat_volumetype}"
    }

  tags {
    Name = "${var.rocketchat_projectname}-Rocketchat-${count.index +1}"
  }

}
