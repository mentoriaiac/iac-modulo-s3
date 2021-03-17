output "this_s3_bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "this_s3_bucket_region" {
  value = aws_s3_bucket.my_bucket.region
}
