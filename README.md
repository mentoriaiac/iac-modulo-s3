# iac-modulo-s3
Módulo s3 para criação e manutenção de bucket na AWS S3.

## Requisitos

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws | >= 3.27 |

## _Providers_

| Name | Version |
|------|---------|
| aws | >= 3.27 |

## Recursos

| Name |
|------|
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |

## _Inputs_

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Nome do bucket | `string` | n/a | yes |
| acl | [ACL](https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl) que será aplicada ao bucket | `string` | `"private"` | no |

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

## _Outputs_

| Name | Description |
|------|-------------|
| this\_s3\_bucket\_id | ID do bucket criado |
| this\_s3\_bucket\_region | Região AWS na qual foi criado o bucket |

## TODO

- [ ] Criar novos recursos no módulo (policy, tags, etc)
- [ ] Adicionar mais exemplos (cenários de utilização do módulo)
- [ ] Adicionar mais testes em cada cenário de utilização
- [ ] Criar pipeline CI com testes automatizados (terratest + localstack)

