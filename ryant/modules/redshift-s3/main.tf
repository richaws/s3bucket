resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucketname}"
  acl    = "private"
  tags = "${var.tags}"
}

data "aws_iam_policy_document" "redshift_iam_policy" {
  statement {
    sid    = 1
    effect = "Allow"
    actions = ["s3:GetObject", "s3:ListBucket","s3:GetBucketLocation", "s3:DeleteObject", "s3:PutObject"]
    resources = ["${aws_s3_bucket.bucket.arn}"]
  }
}

resource "aws_iam_policy" "redshift_iam_policy" {
  name = "redshift_iam_policy_${var.cluster_name}"
  policy = "${data.aws_iam_policy_document.redshift_iam_policy.json}"
}

resource "aws_iam_role_policy" "redshift_iam_policy" {
  name  = "redshift_iam_policy_${var.cluster_name}"
  role = "${aws_iam_role.redshift_iam_role.name}"
  policy = "${data.aws_iam_policy_document.redshift_iam_policy.json}"
}

data "aws_iam_policy_document" "redshift_iam_assume_role" {
  statement {
    sid    = 1
    effect = "Allow"

    principals = {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "redshift_iam_role" {
  name               = "redshift_iam_role_${var.cluster_name}"
  assume_role_policy = "${data.aws_iam_policy_document.redshift_iam_assume_role.json}"
}

resource "aws_iam_policy_attachment" "redshift_iam_attachment" {
  name       = "redshift_iam_attachment"
  roles      = ["${aws_iam_role.redshift_iam_role.name}"]
  policy_arn = "${aws_iam_policy.redshift_iam_policy.arn}"
}

resource "aws_redshift_cluster" "redshift" {
  cluster_identifier = "${var.cluster_name}"
  database_name      = "${var.dbname}"
  master_username    = "${var.username}"
  master_password    = "${var.password}"
  node_type          = "${var.node_type}"
  cluster_type       = "${var.number_of_nodes > 1 ? "multi-node": "single-node"}"
  tags               = "${var.tags}"
  number_of_nodes    = "${var.number_of_nodes}"
  iam_roles          = ["${aws_iam_role.redshift_iam_role.arn}"]
  skip_final_snapshot = true
}