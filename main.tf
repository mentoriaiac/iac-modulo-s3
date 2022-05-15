#tfsec:ignore:aws-s3-enable-bucket-encryption #tfsec:ignore:aws-s3-encryption-customer-key #tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

#tfsec:ignore:aws-s3-ignore-public-acls #tfsec:ignore:aws-s3-no-public-buckets
resource "aws_s3_bucket_public_access_block" "policy_s3" {
  bucket              = aws_s3_bucket.my_bucket.id
  block_public_acls   = var.acl == "public-read" || var.acl == "public-read-write" ? false : true
  block_public_policy = var.acl == "public-read" || var.acl == "public-read-write" ? false : true
}

resource "aws_s3_bucket_acl" "acl_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_logging" "s3_log" {
  bucket = aws_s3_bucket.my_bucket.id

  target_bucket = aws_s3_bucket.my_bucket.id
  target_prefix = var.target_prefix
}
