include Makefile_include.mk
# Default rule/target
.DEFAULT_GOAL := deploy


.PHONY: deploy
## Deploy all components to the gardener cluster
deploy:
	@cat ./yaml/namespace.yaml | \
		sed "s~<DEPLOYMENT_NAMESPACE>~$(DEPLOYMENT_NAMESPACE)~g" | \
		kubectl apply -f - 

	@helm upgrade --install bookinfo \
		--namespace $(DEPLOYMENT_NAMESPACE) \
		./charts

.PHONY: clean
clean:
	@echo "Uninstall Helm chart (timeout 2m)"
	@helm uninstall --namespace  $(DEPLOYMENT_NAMESPACE) \
		bookinfo \
		--ignore-not-found \
		--wait --timeout 2m
	@kubectl delete namespace $(DEPLOYMENT_NAMESPACE)
