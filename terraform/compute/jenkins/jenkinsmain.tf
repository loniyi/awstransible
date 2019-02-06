# ---------------------------------------
# Jenkins Instance
# ---------------------------------------  

resource "aws_instance" "ss_jenkins" {
  ami                    = "${var.jenkins_instanceami}"
  key_name               = "${var.jenkins_keyname}"
  subnet_id             = "${element(var.jenkins_subnet, count.index)}"
  user_data              = "${var.jenkins_userdata}"  
  private_ip             = "${var.jenkins_privateip}"
  instance_type          = "${var.jenkins_instancetype}"
  availability_zone      = "${var.jenkins_availabilityzone}"
  vpc_security_group_ids = ["${var.jenkins_securitygroup}"]
  
  root_block_device {
      volume_size = "${var.jenkins_volumesize}"
      volume_type = "${var.jenkins_volumetype}"
    }

  tags {
    Name = "${var.jenkins_projectname}-Jenkins-${count.index +1}"
  }

}



