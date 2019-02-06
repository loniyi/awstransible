# -----------------------------
# Instances AMI ID
# -----------------------------
data "aws_ami" "instance_ami" {
  most_recent = true

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*-x86_64-gp2"]
 }
}


