variable "region" {
  default = "ap-northeast-2"
  description = "Amazon Region"
}
variable "resource_prefix" {
  default = "DevOS-3-tier-Demo"
  description = "resource name prefix"
  type = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "vpc CIDR Range"
}

variable "subnet_cidr" {
  default = "10.0.1.0/20"
  description = "subnet CIDR Range"
}

variable "bastion_instance_type" {
  default = "t2.micro"
  description = "EC2 Bastion Instance Type"
}

variable "web_instance_type" {
  default = "t2.micro"
  description = "EC2 Web Server Instance Type"
}

variable "was_instance_type" {
  default = "t2.micro"
  description = "EC2 WAS Server Instance Type"
}

variable "bastion_key_pair_name" {
  default = "devos-demo-seoul-bastion-key"
  description = "Bastion Instance Key Pair Name"
}

variable "instance_key_pair_name" {
  default = "devos-demo-seoul-instance-key"
  description = "Instance Key Pair Name"
}

variable "create_db" {
  default = true
  type = bool
  description = "RDS Generated or not"
}

variable "db_name" {
  default = "demodb"
  type = string
  description = "RDS Database Name"
}

variable "db_username" {
  default = "demouser"
  description = "RDS Access User Name"
}

variable "db_password" {
  default = "demopass"
  description = "RDS Access Password"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type = string
  default = "catalog-s3-bucket"
}

variable "bucket_versioning" {
  description = "S3 Bucket Versioning"
  type        = bool
  default     = true
}

variable "bucket_private_acl" {
  description = "S3 Bucket Private ACL"
  type        = bool
  default     = true
}
