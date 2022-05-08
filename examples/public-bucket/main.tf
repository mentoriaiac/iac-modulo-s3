module "s3_bucket" {
  source      = "../../"
  bucket_name = "public-bucket-example"
  acl         = "public-read"
}
