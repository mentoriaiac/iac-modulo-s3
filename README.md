# iac-modulo-s3
Módulo s3 para criação e manutenção de bucket na AWS S3.

## Requisitos

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.27 |

## _Providers_

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.1 |

## Recursos

| Name | Type |
|------|------|
| [aws_s3_bucket.my_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.acl_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.s3_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_public_access_block.policy_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.versioning_example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## _Inputs_

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | ACL aplicada ao bucket | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Nome do bucket | `string` | n/a | yes |

## _Outputs_

| Name | Description |
|------|-------------|
| <a name="output_this_s3_bucket_acl"></a> [this\_s3\_bucket\_acl](#output\_this\_s3\_bucket\_acl) | The acl applied to this bucket |
| <a name="output_this_s3_bucket_id"></a> [this\_s3\_bucket\_id](#output\_this\_s3\_bucket\_id) | The id of this bucket. |
| <a name="output_this_s3_bucket_region"></a> [this\_s3\_bucket\_region](#output\_this\_s3\_bucket\_region) | The aws region of this bucket |


## Como utilizar o módulo

No diretório [_examples/_](examples/) podem ser encontrados exemplos de utilização, incluindo instruções de como executá-los.

Mas para adiantar um exemplo simples, a utilização do módulo pode ser feita da seguinte maneira:

- Criação de um bucket com ACL _private_

```hcl
module "s3_bucket" {
  source      = "github.com/marcelomansur/iac-modulo-s3"
  bucket_name = "my-private-bucket"
}
```

## Como testar o módulo

No diretório [_tests/_](tests/) podem ser encontrados os testes automatizados do módulos, usando terratest + localstack.

Para testar, executar comandos pelo Makefile:

```
$ make localtest-private-bucket # Executa teste de criação de um bucket privado
$ make localtest-public-bucket # Executa teste de criação de um bucket público
```
É necessário ter o `Go >= 1.15` e `Docker >= 20.10.5` para execução dos testes localmente.

## TODO

- [ ] Criar novos recursos no módulo (policy, tags, etc)
- [ ] Adicionar mais exemplos (cenários de utilização do módulo)
- [ ] Adicionar mais testes em cada cenário de utilização
- [ ] Criar pipeline CI com testes automatizados (terratest + localstack)
