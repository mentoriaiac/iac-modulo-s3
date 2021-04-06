cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

SHELL=/bin/bash
LOCALSTACK_CONTAINER=localstack-test-$(shell date +%F)
PUBLIC_TEST_DIR=./tests/public-bucket
PRIVATE_TEST_DIR=./tests/private-bucket
PUBLIC_EXAMPLE_DIR=examples/public-bucket
PRIVATE_EXAMPLE_DIR=examples/private-bucket
TERRAFORM_VERSION=0.14.0

# HELP
# This will output the lp for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

hp: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAT_GOAL := help
#
# Functions
#
# Terraform fmt
terraform-fmt = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) fmt -check
# Terraform init
terraform-init = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) init
# Terraform validate
terraform-validate = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) validate
# Terraform plan
terraform-plan = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan
# Terraform apply
terraform-apply = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) apply -auto-approve
# Terraform destroy
terraform-destroy = docker run --rm -v $$PWD:/app -w /app/$(1) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve
#
# Private bucket
#
# Run static validations
#
terraform-fmt-private-bucket: ## Private bucket example - Run command 'terraform fmt -check'
	  $(call terraform-fmt,$(PRIVATE_EXAMPLE_DIR))

terraform-init-private-bucket: ## Private bucket example - Run command 'terraform init'
	  $(call terraform-init,$(PRIVATE_EXAMPLE_DIR))

terraform-validate-private-bucket: ## Private bucket example - Run command 'terraform validate'
	  $(call terraform-validate,$(PRIVATE_EXAMPLE_DIR))
#
# Run examples on a real AWS environment
#
terraform-plan-private-bucket: ## Private bucket example - Exec a terraform plan and puts it on a file called tfplan
	  $(call terraform-plan,$(PRIVATE_EXAMPLE_DIR))

terraform-apply-private-bucket: ## Private bucket example - Uses tfplan to apply the changes on AWS.
	  $(call terraform-apply,$(PRIVATE_EXAMPLE_DIR))

terraform-destroy-private-bucket: ## Private bucket example - Destroy all resources created by the terraform file in this repo.
	  $(call terraform-destroy,$(PRIVATE_EXAMPLE_DIR))
#
# Public bucket
#
# Run static validations
#
terraform-fmt-public-bucket: ## Public bucket example - Run command 'terraform fmt -check'
	  $(call terraform-fmt,$(PUBLIC_EXAMPLE_DIR))

terraform-init-public-bucket: ## Public bucket example - Run command 'terraform init'
	  $(call terraform-init,$(PUBLIC_EXAMPLE_DIR))

terraform-validate-public-bucket: ## Public bucket example - Run command 'terraform validate'
	  $(call terraform-validate,$(PUBLIC_EXAMPLE_DIR))
#
# Run examples on a real AWS environment
#
terraform-plan-public-bucket: ## Public bucket example - Exec a terraform plan and puts it on a file called tfplan
	  $(call terraform-plan,$(PUBLIC_EXAMPLE_DIR))

terraform-apply-public-bucket: ## Public bucket example - Uses tfplan to apply the changes on AWS.
	  $(call terraform-apply,$(PUBLIC_EXAMPLE_DIR))

terraform-destroy-public-bucket: ## Public bucket example - Destroy all resources created by the terraform file in this repo.
	  $(call terraform-destroy,$(PUBLIC_EXAMPLE_DIR))
#
# Run unit tests
#
unit-tests: terraform-fmt-private-bucket terraform-init-private-bucket terraform-validate-private-bucket ## Run unit tests (terraform fmt and validate)
#
# Run integration tests
#
# Localstack commands
#
localstack-start: ## Start localstack container
		docker run -d --name $(LOCALSTACK_CONTAINER) --rm -p 4566:4566 -p 4571:4571 localstack/localstack -e "SERVICES=s3"

localstack-stop: ## Stop localstack container
		docker kill $(LOCALSTACK_CONTAINER)
#
# Private bucket
#
localtest-private-bucket: localstack-start ## Private bucket test - Run integration test on localstack
		sleep 10
		cd $(PRIVATE_TEST_DIR)/ && go test -v -timeout 30m
		docker kill $(LOCALSTACK_CONTAINER)
#
# Public bucket
#
localtest-public-bucket: localstack-start ## Public bucket test - Run integration test on localstack
		sleep 10
		cd $(PUBLIC_TEST_DIR)/ && go test -v -timeout 30m
		docker kill $(LOCALSTACK_CONTAINER)
#
# Run tests
#
integration-tests: localtest-private-bucket ## Run integration tests
