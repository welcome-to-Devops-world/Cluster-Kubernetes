#/bin/bash

helm repo add harbor https://helm.goharbor.io
helm install harbor harbor/harbor --namespace harbor --create-namespace -f ./harbor-values.yaml