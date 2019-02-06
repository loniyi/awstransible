
# ---------------------------------------
# Gitlab Instance
# ---------------------------------------  
resource "aws_instance" "ss_gitlab" {
  ami                    = "${var.gitlab_instanceami}"
  key_name               = "${var.gitlab_keyname}"
  subnet_id              = "${element(var.gitlab_subnet, count.index)}"
  user_data              = "${var.gitlab_userdata}"  
  private_ip             = "${var.gitlab_privateip}"
  instance_type          = "${var.gitlab_instancetype}"
  availability_zone      = "${var.gitlab_availabilityzone}"
  vpc_security_group_ids = ["${var.gitlab_securitygroup}"]
  
  root_block_device {
      volume_size = "${var.gitlab_volumesize}"
      volume_type = "${var.gitlab_volumetype}"
    }

  tags {
    Name = "${var.gitlab_projectname}-Gitlab-${count.index +1}"
  }

}