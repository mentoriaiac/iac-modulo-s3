output "this_s3_bucket_id" {
  value       = module.s3_bucket.this_s3_bucket_id
  description = "The id of this bucket."
}

output "this_s3_bucket_region" {
  value       = module.s3_bucket.this_s3_bucket_region
  description = "The aws region of this bucket"
}

output "this_s3_bucket_acl" {
  value       = module.s3_bucket.this_s3_bucket_acl
  description = "The acl applied to this bucket"
}
