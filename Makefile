LOCALSTACK_CONTAINER=localstack-test-$(shell date +%F)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

localstack-start: ## Run localstack container
		docker run -d --name $(LOCALSTACK_CONTAINER) --rm -p 4566:4566 -p 4571:4571 localstack/localstack -e "SERVICES=s3"

localstack-stop: ## Stop localstack container
		docker kill $(LOCALSTACK_CONTAINER)

test-default: localstack-start ## Run the default test example
		sleep 10
		cd examples/default/ && go test -v -timeout 30m
		docker kill $(LOCALSTACK_CONTAINER)
