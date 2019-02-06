#---Instance Profile
output "app_s3instanceprofile" {
  description = "IAM Instance Profile for Application Servers"
  value       = "${aws_iam_instance_profile.app_s3accessprofile.id}"
}


#---S3 Bucket Name ID
output "s3_bucketname" {
  value = "${aws_s3_bucket.ss_s3bucket.id}"
}

#---S3 Bucket ARN
output "s3_bucketarn" {
  value = "${aws_s3_bucket.ss_s3bucket.arn}"
}