module "redshift_s3" {
  source = "../modules/redshift-s3"
  bucketname = "${var.bucketname}"
  node_type  = "${var.node_type}"
  username   = "${var.username}"
  password   = "${var.password}"
  number_of_nodes = "${var.number_of_nodes}"
  tags  = "${var.tags}"
  cluster_name = "${var.cluster_name}"
}