# ---------------------------------------
# Launch Configuration
# ---------------------------------------
resource "aws_launch_configuration" "app_launchconfiguration" {
  key_name             = "${var.app_keyname}"  
  image_id             = "${var.app_instanceami}"  
  user_data            = "${var.app_userdata}"
  name_prefix          = "${var.app_projectname}_ApplicationLC"
  instance_type        = "${var.app_instancetype}"
  security_groups      = ["${var.app_lcsecuritygroups}"]
  iam_instance_profile = "${var.app_instanceprofile}"
  
  lifecycle {
    create_before_destroy = "true"
  }
}

# --------------------------
# Application Auto-Scaling Group
# --------------------------
resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.app_projectname}_ApplicationASG"
  max_size                  = "${var.app_asgmaxsize}"
  min_size                  = "${var.app_asgminsize}"
  force_delete              = "true"
  load_balancers            = ["${var.app_loadbalancers}"]
  desired_capacity          = "${var.app_asgcapacity}"
  health_check_type         = "${var.app_asghct}"  
  vpc_zone_identifier       = ["${var.app_asgsubnets}"]
  launch_configuration      = "${aws_launch_configuration.app_launchconfiguration.name}"
  health_check_grace_period = "${var.app_asggrace}"

  tag {
    key                 = "Name"
    value               = "${var.app_projectname}-AppServer"
    propagate_at_launch = "true"
  }

  lifecycle {
    create_before_destroy = "true"
  }
}


data "aws_instances" "app_asg" { 
  instance_tags {
    Name = "${var.app_projectname}-AppServer"
  }
  depends_on = ["aws_autoscaling_group.app_asg"]
}



data "aws_instances" "application_asg" {
  depends_on = [ "aws_autoscaling_group.app_asg" ]
  
  instance_tags {
    Name = "${var.app_projectname}-AppServer"
  }
}

data "aws_instance" "asg-one-instances" {
  count = "${var.app_asgcapacity}"
  depends_on = ["data.aws_instances.application_asg"]
  instance_id = "${data.aws_instances.application_asg.ids[count.index]}"
}

