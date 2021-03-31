output "this_s3_bucket_id" {
  value       = aws_s3_bucket.my_bucket.id
  description = "The id of this bucket."
}

output "this_s3_bucket_region" {
  value       = aws_s3_bucket.my_bucket.region
  description = "The aws region of this bucket"
}

output "this_s3_bucket_acl" {
  value       = aws_s3_bucket.my_bucket.acl
  description = "The aws region of this bucket"
}


