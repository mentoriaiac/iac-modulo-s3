module "s3_bucket" {
  source      = "../../"
  bucket_name = "public-bucket-example222"
  acl         = "private"
}
