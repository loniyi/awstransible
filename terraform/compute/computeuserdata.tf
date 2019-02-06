# ---------------------------------------
# DevOps Compute Userdata Bootstrap file
# ---------------------------------------  
data "template_file" "compute_devopsuserdata" {
  template = "${file("${path.module}/computedevopsuserdata.tpl")}"
 
}

# ---------------------------------------
# Application Compute Userdata Bootstrap file
# ---------------------------------------  
data "template_file" "compute_appuserdata" {
  template = "${file("${path.module}/computeappuserdata.tpl")}"
  
  vars {
    message = "Welcome!!!!"
  }
}
