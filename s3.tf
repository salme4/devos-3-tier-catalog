resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = local.bucket_versioning
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = local.bucket_private_acl
}
