
# ---------------------------------------
# S3 Access Role
# ---------------------------------------
resource "aws_iam_role" "app_s3accessrole" {
  name = "${var.s3_projectname}_app_s3accessrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
  },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
}
EOF
}



# ---------------------------------------
# APP S3 Access Policy
# ---------------------------------------
resource "aws_iam_role_policy" "app_s3accesspolicy" {
  name = "${var.s3_projectname}_app_s3accesspolicy"
  role = "${aws_iam_role.app_s3accessrole.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}



# ---------------------------------------
# APP S3 Access Profile
# ---------------------------------------

resource "aws_iam_instance_profile" "app_s3accessprofile" {
  name = "${var.s3_projectname}_app_s3accessprofile"
  role = "${aws_iam_role.app_s3accessrole.name}"
}

