output "redshift_endpoint" {
  value = "${aws_redshift_cluster.redshift.endpoint}"
}

output "aws_s3_bucket_arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}