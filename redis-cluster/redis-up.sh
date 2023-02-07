#/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install redis bitnami/redis --namespace redis --create-namespace -f ./redis-values.yaml