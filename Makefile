# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

localstack-start: ## Run localstack start
		docker run --rm -p 4566:4566 -p 4571:4571 localstack/localstack -e "SERVICES=s3"

test: ## Run terraform tests
		cd examples/default/ && go test -v -timeout 30m
