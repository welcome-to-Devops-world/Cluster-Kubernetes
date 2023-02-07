- Note: 
# Helm Chart for Harbor

Notes: The master branch is in heavy development, please use the other stable versions instead. A high available solution for Harbor based on chart can be find here. And refer to the guide to upgrade the existing deployment.

This repository, including the issues, focus on deploying Harbor chart via helm. So for the functionality issues or questions of Harbor, please open issues on goharbor/harbor
## Introduction

This Helm chart installs Harbor in a Kubernetes cluster.
Prerequisites

   - Kubernetes cluster 1.20+
   -  Helm v3.2.0+


This Helm chart has been developed based on goharbor/harbor-helm chart but including some features common to the Bitnami chart library. For example, the following changes have been introduced:

- Possibility to pull all the required images from a private registry through the Global Docker image parameters.
- Redis™ and PostgreSQL are managed as chart dependencies.
- Liveness and Readiness probes for all deployments are exposed to the values.yaml.
- Uses new Helm chart labels formatting.
- Uses Bitnami container images:
    - non-root by default
    - published for debian-10 and ol-7
- This chart support the Harbor optional components Chartmuseum, Clair and Notary integrations.


## Installation
Configure the chart

Configured by editing the harbor-values.yaml directly.
Configure the way how to expose Harbor service

We are using the Ingress mode and the information for it is set in the harbor-values.yaml file.

-  Ingress: The ingress controller must be installed in the Kubernetes cluster. Notes: if the TLS is disabled, the port must be included in the command when pulling/pushing images. Refer to issue #5291 for the detail.
- ClusterIP: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster.
- NodePort: Exposes the service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service, from outside the cluster, by requesting NodeIP:NodePort.
- LoadBalancer: Exposes the service externally using a cloud provider’s load balancer.

## Install Helm

By running the following command the harbor will create harbor namespace (if not exist).
```
./harbor-up.sh
```
```
root@master01-k8s-cluster:~/cluster/harbor# kubectl get all -n harbor
NAME                                        READY   STATUS    RESTARTS   AGE
pod/harbor-chartmuseum-64fb6d86b6-h5cgt     1/1     Running   0          35m
pod/harbor-core-795f79c4f7-dqwd2            1/1     Running   0          35m
pod/harbor-database-0                       1/1     Running   0          35m
pod/harbor-jobservice-646bbbd44b-cnklh      1/1     Running   0          35m
pod/harbor-notary-server-69db9786d6-nb9nw   1/1     Running   0          35m
pod/harbor-notary-signer-6948889478-4l8bn   1/1     Running   0          35m
pod/harbor-portal-d49cc656c-589wc           1/1     Running   0          35m
pod/harbor-redis-0                          1/1     Running   0          33m
pod/harbor-registry-57d8785456-tjxkj        2/2     Running   0          35m
pod/harbor-trivy-0                          1/1     Running   0          35m

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
service/harbor-chartmuseum     ClusterIP   10.233.47.107   <none>        80/TCP              35m
service/harbor-core            ClusterIP   10.233.44.204   <none>        80/TCP              35m
service/harbor-database        ClusterIP   10.233.12.180   <none>        5432/TCP            35m
service/harbor-jobservice      ClusterIP   10.233.40.193   <none>        80/TCP              35m
service/harbor-notary-server   ClusterIP   10.233.24.223   <none>        4443/TCP            35m
service/harbor-notary-signer   ClusterIP   10.233.35.246   <none>        7899/TCP            35m
service/harbor-portal          ClusterIP   10.233.62.175   <none>        80/TCP              35m
service/harbor-redis           ClusterIP   10.233.32.89    <none>        6379/TCP            35m
service/harbor-registry        ClusterIP   10.233.9.243    <none>        5000/TCP,8080/TCP   35m
service/harbor-trivy           ClusterIP   10.233.22.2     <none>        8080/TCP            35m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/harbor-chartmuseum     1/1     1            1           35m
deployment.apps/harbor-core            1/1     1            1           35m
deployment.apps/harbor-jobservice      1/1     1            1           35m
deployment.apps/harbor-notary-server   1/1     1            1           35m
deployment.apps/harbor-notary-signer   1/1     1            1           35m
deployment.apps/harbor-portal          1/1     1            1           35m
deployment.apps/harbor-registry        1/1     1            1           35m

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/harbor-chartmuseum-64fb6d86b6     1         1         1       35m
replicaset.apps/harbor-core-795f79c4f7            1         1         1       35m
replicaset.apps/harbor-jobservice-646bbbd44b      1         1         1       35m
replicaset.apps/harbor-notary-server-69db9786d6   1         1         1       35m
replicaset.apps/harbor-notary-signer-6948889478   1         1         1       35m
replicaset.apps/harbor-portal-d49cc656c           1         1         1       35m
replicaset.apps/harbor-registry-57d8785456        1         1         1       35m

NAME                               READY   AGE
statefulset.apps/harbor-database   1/1     35m
statefulset.apps/harbor-redis      1/1     35m
statefulset.apps/harbor-trivy      1/1     35m
root@master01-k8s-cluster:~/cluster/harbor# kubectl get ingress -n harbor
NAME                    CLASS   HOSTS                                 ADDRESS         PORTS     AGE
harbor-ingress          nginx   core-harbor-k8s-cluster.Domain.ir     1.1.1.201   80, 443   36m
harbor-ingress-notary   nginx   notary-harbor-k8s-cluster.Domain.ir   1.1.1.201   80, 443   36m

```
## Notes

- Remember to set the appropriate url address in the harbor-values.yaml file depending on the deployment location.
- We have disabled the built-in Redis server instance and used an external redis. Make sure to provide the information for redis connection in the harbor-values.yaml file
- We have added LinkerD integration and annotated the pods in order to get information and use in-cluster service mesh.
- Harbor will persist all data by claiming a persistent volume. So upon chart update there is no need to we worried as long as it claims the old PVC.
- The default username is admin and password is Harbor12345 but you can run the following command in order to retrieve the password from secret:
```
    kubectl get secret -n harbor harbor-core -o jsonpath='{.data.HARBOR_ADMIN_PASSWORD}' | base64 -d
```
```
root@master01-k8s-cluster:~/cluster/harbor# kubectl get secrets -n harbor
NAME                           TYPE                                  DATA   AGE
default-token-sl4fb            kubernetes.io/service-account-token   3      48m
harbor-chartmuseum             Opaque                                1      48m
harbor-core                    Opaque                                8      48m
harbor-database                Opaque                                1      48m
harbor-ingress                 kubernetes.io/tls                     3      48m
harbor-jobservice              Opaque                                2      48m
harbor-notary-server           Opaque                                5      48m
harbor-registry                Opaque                                2      48m
harbor-registry-htpasswd       Opaque                                1      48m
harbor-registryctl             Opaque                                0      48m
harbor-trivy                   Opaque                                2      48m
sh.helm.release.v1.harbor.v1   helm.sh/release.v1                    1      48m

root@master01-k8s-cluster:~/cluster/harbor# kubectl get secret -n harbor harbor-core -o jsonpath='{.data.HARBOR_ADMIN_PASSWORD}' | base64 -d
Harbor12345
```
 Make sure to change the default username and password after installation or you can set them in the harbor-values.yaml file before installation.

```
# kubectl create secret docker-registry  registry-cluster.Domain.local --docker-server=https://core-harbor-k8s-cluster.placker-password=password --docker-email=Domain.Domain@gmail.com
secret/registry-cluster.Domain.local created
# kubectl get secrets
NAME                                TYPE                                  DATA   AGE
registry-cluster.Domain.local       kubernetes.io/dockerconfigjson        1      13m

```