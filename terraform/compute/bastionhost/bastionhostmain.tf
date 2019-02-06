# ------------------
# BastionHost Elastic IP
# ------------------
resource "aws_eip" "bastionhost_eipaddress" {
  vpc = "true"
}

# ----------------
# BastionHost EC2 Role
# ----------------
resource "aws_iam_role" "bastionhost_ec2role" {
  name = "${var.bastionhost_projectname}_BastionHostEC2role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# ------------------
# BastionHost EC2 Policy
# ------------------
resource "aws_iam_policy" "bastionhost_ec2policy" {
  name        = "${var.bastionhost_projectname}_BastionHostEC2Policy"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1477071439000",
      "Effect": "Allow",
      "Action": [
        "ec2:AssociateAddress"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

# ---------------------------------
# Attach BastionHost EC2 Policy to Role
# ---------------------------------
resource "aws_iam_role_policy_attachment" "bastionhost_attach_ec2policy" {
  role       = "${aws_iam_role.bastionhost_ec2role.name}"
  policy_arn = "${aws_iam_policy.bastionhost_ec2policy.arn}"
}

# ------------------------------
# BastionHost CloudWatch Logs Policy
# ------------------------------
resource "aws_iam_policy" "bastionhost_logspolicy" {
  name        = "${var.bastionhost_projectname}_BastionHostLogsPolicy"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:*:*:*"
      ]
    }
  ]
}
EOF
}

# ----------------------------------
# Attach BastionHost Logs Policy to Role
# ----------------------------------
resource "aws_iam_role_policy_attachment" "bastionhost_attachlogspolicy" {
  role       = "${aws_iam_role.bastionhost_ec2role.name}"
  policy_arn = "${aws_iam_policy.bastionhost_logspolicy.arn}"
}

# ----------------------------
# BastionHost EC2 Instance Profile
# ----------------------------
resource "aws_iam_instance_profile" "bastionhost_instanceprofile" {
  name = "${var.bastionhost_projectname}_BastionHostInstanceProfile"
  role = "${aws_iam_role.bastionhost_ec2role.name}"
}

# ---------------------------------------
# Render BastionHost Userdata Bootstrap File
# ---------------------------------------
data "template_file" "bastionhost_userdata" {
  template = "${file("${path.module}/bastionhostuserdata.tpl")}"

  vars {
    REGION = "${var.bastionhost_region}"
    EIP_ID = "${aws_eip.bastionhost_eipaddress.id}"
  }
}

# ----------------------------
# BastionHost Launch Configuration
# ----------------------------
resource "aws_launch_configuration" "bastionhost_launchconfiguration" {
  image_id                    = "${var.bastionhost_instanceami}"
  key_name                    = "${var.bastionhost_keyname}"
  user_data                   = "${data.template_file.bastionhost_userdata.rendered}"
  name_prefix                 = "${var.bastionhost_projectname}_BastionHostLC"
  instance_type               = "${var.bastionhost_instancetype}"
  security_groups             = ["${var.bastionhost_securitygroup}"]
  enable_monitoring           = "${var.bastionhost_enablemonitoring}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastionhost_instanceprofile.name}"
  associate_public_ip_address = "false"

  lifecycle {
    create_before_destroy     = "true"
  }
}

# --------------------------
# BastionHost Auto-Scaling Group
# --------------------------
resource "aws_autoscaling_group" "bastionhost_asg" {
  name                 = "${var.bastionhost_projectname}_BastionHostASG"
  max_size             = "${var.bastionhost_maxsize}"
  min_size             = "${var.bastionhost_minsize}"
  desired_capacity     = "${var.bastionhost_desiredcapacity}"
  vpc_zone_identifier  = ["${var.bastionhost_asgsubnets}"]
  launch_configuration = "${aws_launch_configuration.bastionhost_launchconfiguration.name}"

  tag {
    key                 = "Name"
    value               = "${var.bastionhost_projectname}_BastionHostASG"
    propagate_at_launch = "true"
  }
}