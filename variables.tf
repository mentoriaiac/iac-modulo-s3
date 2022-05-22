variable "bucket_name" {
  type        = string
  description = "Nome do bucket"
}

variable "acl" {
  type        = string
  description = "ACL aplicada ao bucket"
  default     = "private"
  validation {
    condition     = contains(["private", "public-read", "public-read-write", "aws-exec-read", "authenticated-read", "log-delivery-write"], var.acl)
    error_message = "ACL inválida, valores permitidos: private, public-read, public-read-write, aws-exec-read, authenticated-read, log-delivery-write."
  }
}

variable "versioning_status" {
  type = string
  description = "Ativa/desativa o versionamento do bucket"
  default = "Enabled"
}

variable "target_prefix" {
  type = string
  description = "Específica um prefixo para o armazendamento de objetos de log"
  default = "/log"
}
