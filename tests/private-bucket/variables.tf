variable "bucket_name" {
  description = "bucket name"
  type        = string
}

variable "acl" {
  description = "acl"
  type        = string
  default     = "private"
}
