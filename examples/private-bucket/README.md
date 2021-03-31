# Bucket com acesso privado

## Como usar

Na raiz do projeto, criar um arquivo `.env` a partir do arquivo `.env.example`, contendo as credenciais do provider AWS.

```
AWS_ACCESS_KEY_ID=<seu_id_aqui>
AWS_SECRET_ACCESS_KEY=<sua_chave_aqui>
```

Também na raiz do projeto, executar os comandos Makefile relacionados ao exemplo:

```
$ terraform-init-private-bucket
$ terraform-plan-private-bucket
$ terraform-apply-private-bucket
$ terraform-destroy-private-bucket
```

## Requisitos

| Nome | Versão |
|------|---------|
| terraform | >= 0.14.0 |
| aws | >= 3.27 |

## _Providers_

| Name | Version |
|------|---------|
| aws | >= 3.27 |

## Módulos

| Nome | Source | Versão |
|------|--------|---------|
| s3_bucket | ../../ |  |

## Recursos

Nenhum recurso.

## _Inputs_

Nenhum _input_.

## _Outputs_

| Nome | Descrição |
|------|-------------|
| this\_s3\_bucket\_id | ID do bucket criado |
| this\_s3\_bucket\_region | Região AWS na qual foi criado o bucket |
| this\_s3\_bucket\_acl | ACL aplicada ao bucket |
