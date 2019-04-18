output "redshift_endpoint" {
  value = "${module.redshift_s3.redshift_endpoint}"
}

output "aws_s3_bucket_arn" {
  value = "${module.redshift_s3.aws_s3_bucket_arn}"
}