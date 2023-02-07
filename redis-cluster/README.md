# Redis Chart

TThis chart bootstraps a Redis™ deployment on a Kubernetes cluster using the Helm package manager. It has been tested to work with NGINX Ingress, cert-manager, Prometheus and linkerd.

## Introduction

This chart bootstraps a Redis™ deployment on a Kubernetes cluster using the Helm package manager.

Bitnami charts can be used with Kubeapps for deployment and management of Helm Charts in clusters. This chart has been tested to work with NGINX Ingress, cert-manager, fluentd and Prometheus on top of the BKPR.
Choose between Redis™ Helm Chart and Redis™ Cluster Helm Chart

You can choose any of the two Redis™ Helm charts for deploying a Redis™ cluster. While Redis™ Helm Chart will deploy a master-slave cluster using Redis™ Sentinel, the Redis™ Cluster Helm Chart will deploy a Redis™ Cluster with sharding. The main features of each chart are the following:

|Redis™ |Redis™ Cluster|
|-|-|
|Supports multiple databases|Supports only one database. Better if you have a big dataset|
|Single write point (single master)| 	Multiple write points (multiple masters)
|-|-|

## Additional Information

Redis server is installed with a predefined root password in order to provide to other services.

To upgrade the redis helm using the normal helm upgrade command, we have to provide the root password in order to upgrade it , the syntax can be find by running the helm upgrade without the root password.

## Parameters
### Parameters
|Name|Description|Value|
|-|-|-|
|global.imageRegistry|Global Docker image registry |""|
|global.imagePullSecrets |Global Docker registry secret names as an array |[]|
|global.storageClass|Global StorageClass for Persistent Volume(s)|""|
|global.redis.password|Redis™ password (overrides password) |""|
|clusterDomain |Kubernetes Cluster Domain |cluster.local|

Also we are adding some annotations for Linkerd. By default linkerd does not opaque redis port so we have to opaque port '6379' manually which is added to the values file.
## Prerequisites

    - Kubernetes 1.12+
    - Helm 3.1.0
    - PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name Redis:
```
$ ./redis-up.sh
```
   Note: Complete values of this helm repo is provided in this link.

```
root@master01-k8s-cluster:~/cluster/redis# helm install redis bitnami/redis --namespace redis --create-namespace -f ./redis-values.yaml
NAME: redis
LAST DEPLOYED: Tue Mar 15 05:29:08 2022
NAMESPACE: redis
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: redis
CHART VERSION: 16.4.5
APP VERSION: 6.2.6

** Please be patient while the chart is being deployed **

Redis&trade; can be accessed on the following DNS names from within your cluster:

    redis-master.redis.svc.k8s-cluster.Domain.local for read/write operations (port 6379)
    redis-replicas.redis.svc.k8s-cluster.Domain.local for read-only operations (port 6379)



To get your password run:

    export REDIS_PASSWORD=$(kubectl get secret --namespace redis redis -o jsonpath="{.data.redis-password}" | base64 --decode)

To connect to your Redis&trade; server:

1. Run a Redis&trade; pod that you can use as a client:

   kubectl run --namespace redis redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:6.2.6-debian-10-r154 --command -- sleep infinity

   Use the following command to attach to the pod:

   kubectl exec --tty -i redis-client \
   --namespace redis -- bash

2. Connect using the Redis&trade; CLI:
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-replicas

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace redis svc/redis-master : &
    REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p
root@master01-k8s-cluster:~/cluster/redis#


```
for check:
```
root@master01-k8s-cluster:~/cluster# kubectl get all -n redis
NAME                   READY   STATUS    RESTARTS   AGE
pod/redis-master-0     3/3     Running   0          3h41m
pod/redis-replicas-0   3/3     Running   0          3h41m
pod/redis-replicas-1   3/3     Running   0          3h39m
pod/redis-replicas-2   3/3     Running   0          3h36m

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/redis-headless   ClusterIP   None            <none>        6379/TCP   3h41m
service/redis-master     ClusterIP   10.233.20.39    <none>        6379/TCP   3h41m
service/redis-metrics    ClusterIP   10.233.16.108   <none>        9121/TCP   3h41m
service/redis-replicas   ClusterIP   10.233.44.247   <none>        6379/TCP   3h41m

NAME                              READY   AGE
statefulset.apps/redis-master     1/1     3h41m
statefulset.apps/redis-replicas   3/3     3h41m
root@master01-k8s-cluster:~/cluster# kubectl get pvc -n redis
NAME                          STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                AGE
redis-data-redis-master-0     Bound    pvc-adf6af37-1e97-4184-9558-c9b7aa52c2a5   8Gi        RWO            rook-cephfs-cluster-retain   3h41m
redis-data-redis-replicas-0   Bound    pvc-4acb7bcc-475e-427a-93af-2712297e0901   8Gi        RWO            rook-cephfs-cluster-retain   3h41m
redis-data-redis-replicas-1   Bound    pvc-e5f8cde3-4a2e-4853-8b4e-7879499da19c   8Gi        RWO            rook-cephfs-cluster-retain   3h39m
redis-data-redis-replicas-2   Bound    pvc-7da9e275-03ee-4561-8571-8015c8d456fc   8Gi        RWO            rook-cephfs-cluster-retain   3h36m
root@master01-k8s-cluster:~/cluster#

```
## Uninstalling the Chart

To uninstall/delete the Redis deployment:
```
$ ./redis-down.sh
```
The command removes all the Kubernetes components associated with the chart and deletes the release.