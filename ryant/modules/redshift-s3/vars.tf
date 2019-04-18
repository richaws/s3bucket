variable "awsregion" {
  type = "string"
  description = "AWS Region"
  default = "us-east-1"
}

variable "bucketname" {
  type = "string"
  description = "Name of S3 Bucket"
}

variable "cluster_name" {
  type = "string"
  description = "Redshift Cluster Name"
}

variable "dbname" {
  type = "string"
  description = "Redshift database name"
  default = "default_value"
}

variable "node_type" {
  type = "string"
  description = "Redshift Node Type"
}

variable "username" {
  type = "string"
  description = "Redshift User Name"
}

variable "password" {
  type = "string"
  description = "Redshift Password"
}

variable "number_of_nodes" {
  type = "string"
  description = "Number of Nodes"
  default = "default_value"
}

variable "tags" {
  type = "map"
  description = "Map of Tags"
}