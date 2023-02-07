# PostgreSQL HA Chart

This chart bootstraps a PostgreSQL deployment on a Kubernetes cluster using the Helm package manager. It has been tested to work with NGINX Ingress, cert-manager and linkerd.
Additional Information

Postgresql server is installed with a predefined root password in order to provide to other services. We are creating 3 databases for Gitlab and also for Harbor and we are doing this using scripts in values file. Both of these changes are added in the values file.

Also we are adding some annotations for Linkerd. By default linkerd opaque posgresql port so we don’t need to do anything manually.
## Prerequisites

   - Kubernetes 1.12+
   - Helm 3.1.0
   - PV provisioner support in the underlying infrastructure

## Parameters
parameters
|Name |Description |Value|
|-|-|-|
|global.imageRegistry |Global Docker image registry |""|
global.imagePullSecrets |Global Docker registry secret names as an array |[]
global.storageClass |Global StorageClass for Persistent Volume(s) |""|
global.postgresql.username |PostgreSQL username (overrides postgresql.username) |""|
global.postgresql.password |PostgreSQL password (overrides postgresql.password) |""|
global.postgresql.database |PostgreSQL database (overrides postgresql.database) 	""
global.postgresql.repmgrUsername |PostgreSQL repmgr username (overrides postgresql.repmgrUsername) |""|
global.postgresql.repmgrPassword |PostgreSQL repmgr password (overrides postgresql.repmgrpassword) |""|
|clusterDomain |Kubernetes Cluster Domain |cluster.local|

## Installing the Chart

To install the chart with the release name postgresql:
```
$ ./postgresql-up.sh
```
 Note: Complete values of this helm repo is provided in this link.

```
root@master01-k8s-cluster:~/postgresql# helm upgrade --install postgresql bitnami/postgresql --namespace postgresql --create-namespace -f ./values.yaml
Release "postgresql" does not exist. Installing it now.
NAME: postgresql
LAST DEPLOYED: Wed Mar  9 04:57:39 2022
NAMESPACE: postgresql
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 11.1.3
APP VERSION: 14.2.0

** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    postgresql.postgresql.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace postgresql postgresql -o jsonpath="{.data.postgres-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace postgresql --image docker.io/bitnami/postgresql:14.2.0-debian-10-r22 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
      --command -- psql --host postgresql -U postgres -d postgresDatabase -p 5432

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace postgresql svc/postgresql 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgresDatabase -p 5432
```

## Uninstalling the Chart

To uninstall/delete the postgresql deployment:
```
$ ./postgresql-down.sh
```
The command removes all the Kubernetes components but PVC's associated with the chart and deletes the release.

To delete the PVC's associated with postgresql:
```
$ kubectl delete pvc -l release=postgresql -n postgresql
```
 Note: Deleting the PVC's will delete postgresql data as well. Please be cautious before doing it.
