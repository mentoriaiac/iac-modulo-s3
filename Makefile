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
# Run examples on a real AWS environment
#
# Private bucket
terraform-init-private-bucket: ## Private bucket example - Run terraform init to download all necessary plugins
	  docker run --rm -v $$PWD:/app -w /app/$(PRIVATE_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) init -upgrade=true

terraform-plan-private-bucket: ## Private bucket example - Exec a terraform plan and puts it on a file called tfplan
	  docker run --rm -v $$PWD:/app -w /app/$(PRIVATE_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan

terraform-apply-private-bucket: ## Private bucket example - Uses tfplan to apply the changes on AWS.
	  docker run --rm -v $$PWD:/app -w /app/$(PRIVATE_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) apply -auto-approve

terraform-destroy-private-bucket: ## Private bucket example - Destroy all resources created by the terraform file in this repo.
	  docker run --rm -v $$PWD:/app -w /app/$(PRIVATE_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve

# Public bucket
terraform-init-public-bucket: ## Public bucket example - Run terraform init to download all necessary plugins
	  docker run --rm -v $$PWD:/app -w /app/$(PUBLIC_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) init -upgrade=true

terraform-plan-public-bucket: ## Public bucket example - Exec a terraform plan and puts it on a file called tfplan
	  docker run --rm -v $$PWD:/app -w /app/$(PUBLIC_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan

terraform-apply-public-bucket: ## Public bucket example - Uses tfplan to apply the changes on AWS.
	  docker run --rm -v $$PWD:/app -w /app/$(PUBLIC_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) apply -auto-approve

terraform-destroy-public-bucket: ## Public bucket example - Destroy all resources created by the terraform file in this repo.
	  docker run --rm -v $$PWD:/app -w /app/$(PUBLIC_EXAMPLE_DIR) -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve
#
# Run tests on localstack
#
# Single step commands
localstack-start: ## Start localstack container
		docker run -d --name $(LOCALSTACK_CONTAINER) --rm -p 4566:4566 -p 4571:4571 localstack/localstack -e "SERVICES=s3"

localstack-stop: ## Stop localstack container
		docker kill $(LOCALSTACK_CONTAINER)

test-private-bucket: ## Run the private-bucket test command
		cd $(PRIVATE_TEST_DIR)/ && go test -v -timeout 30m

test-public-bucket: ## Run the public-bucket test command
		cd $(PUBLIC_TEST_DIR)/ && go test -v -timeout 30m

# Complete tests
# Private bucket
localtest-private-bucket: localstack-start ## Run the private-bucket test example on localstack
		sleep 10
		cd $(PRIVATE_TEST_DIR)/ && go test -v -timeout 30m
		docker kill $(LOCALSTACK_CONTAINER)

# Public bucket
localtest-public-bucket: localstack-start ## Run the public-bucket test example on localstack
		sleep 10
		cd $(PUBLIC_TEST_DIR)/ && go test -v -timeout 30m
		docker kill $(LOCALSTACK_CONTAINER)
