##----------storage/main.tf-------

# Create a random id 

resource "random_id" "ss_bucket_id" {
  byte_length = 2
}

# Create the bucket

resource "aws_s3_bucket" "ss_s3bucket" {
  bucket        = "${var.s3_projectname}-${random_id.ss_bucket_id.dec}"
  acl           = "private"
  force_destroy = true
   
  versioning {
    enabled = true
  }
 
  tags {
    Name = "ss_bucket"
  }
}
