#/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install postgresql bitnami/postgresql --namespace postgresql --create-namespace -f ./postgresql-values.yaml