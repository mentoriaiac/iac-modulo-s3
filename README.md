# iac-modulo-s3
Módulo s3 para criação e manutenção de bucket na AWS S3.

## Requisitos

| Name | Version |
|------|---------|
| aws | ~> 3.27 |

## _Providers_

| Name | Version |
|------|---------|
| aws | ~> 3.27 |

## Recursos

| Name |
|------|
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |

## _Inputs_

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Nome do bucket | `string` | n/a | yes |
| acl | [ACL](https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl) que será aplicada ao bucket | `string` | `"private"` | no |

## Utilização

- Criação de um bucket com ACL _private_

```hcl
module "s3_bucket" {
  source      = "github.com/marcelomansur/iac-modulo-s3"
  bucket_name = "my-private-bucket"
}
```

- Criação de um bucket com ACL _public-read_

```hcl
module "s3_bucket" {
  source      = "github.com/marcelomansur/iac-modulo-s3"
  bucket_name = "my-public-bucket"
  acl         = "public-read"
}
```

## _Outputs_

| Name | Description |
|------|-------------|
| this\_s3\_bucket\_id | ID do bucket criado |
| this\_s3\_bucket\_region | Região AWS na qual foi criado o bucket |
