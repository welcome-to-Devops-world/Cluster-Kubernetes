# Ceph Cluster Helm Chart

Creates Rook resources to configure a Ceph cluster using the Helm package manager. This chart is a simple packaging of templates that will optionally create Rook resources such as:

    CephCluster, CephFilesystem, and CephObjectStore CRs
    Storage classes to expose Ceph RBD volumes, CephFS volumes, and RGW buckets
    Ingress for external access to the dashboard
    Toolbox

## Prerequisites

   -  Kubernetes 1.13+
    - Helm 3.x
    - Metalb
    - Preinstalled Rook Operator. See the Helm Operator topic to install.

## Installing

The helm install command deploys rook on the Kubernetes cluster in the default configuration. The configuration section lists the parameters that can be configured during installation. It is recommended that the rook operator be installed into the rook-ceph namespace. The clusters can be installed into the same namespace as the operator or a separate namespace.

Rook currently publishes builds of this chart to the release and master channels.

Before installing, review the values.yaml to confirm if the default settings need to be updated.

-     If the operator was installed in a namespace other than rook-ceph, the namespace must be set in the operatorNamespace variable.
    Set the desired settings in the cephClusterSpec. The [defaults](https://github.com/rook/rook/tree/{{ branchName }}/deploy/charts/rook-ceph-cluster/values.yaml) are only an example and not likely to apply to your cluster.
    The monitoring section should be removed from the cephClusterSpec, as it is specified separately in the helm settings.
    The default values for cephBlockPools, cephFileSystems, and CephObjectStores will create one of each, and their corresponding storage classes.

```
~# kubectl get pod -n metallb -o wide
NAME                                  READY   STATUS    RESTARTS      AGE     IP              NODE                                NOMINATED NODE   READINESS GATES
metallb-controller-575ffcd7dc-qjt5q   1/1     Running   3 (84m ago)   4h20m   10.233.92.9     worker03-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-8kngh                 1/1     Running   0             78m     1.1.1.122   worker02-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-f9rn5                 1/1     Running   0             4h20m   1.1.1.117   master02-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-frqf4                 1/1     Running   0             4h20m   1.1.1.118   master03-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-gz28s                 1/1     Running   0             4h20m   1.1.1.116   master01-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-hnsln                 1/1     Running   3 (83m ago)   4h20m   1.1.1.121   worker01-k8s-cluster.Domain.local   <none>           <none>
metallb-speaker-t9p45                 1/1     Running   3 (84m ago)   4h20m   1.1.1.123   worker03-k8s-cluster.Domain.local   <none>           <none>
```
```
helm repo add rook-release https://charts.rook.io/release
helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph
```
```
git clone https://github.com/rook/rook.git

cd /storage/rook/deploy/examples
kubectel -f crds.yaml -f common.yaml operator.yaml
cluster.yaml

```
```
lsblk -f
```
```
 kubectl apply -f toolbox.yam
```
```
root@master01-k8s-cluster:~/storage/rook/deploy/examples# kubectl -n rook-ceph rollout status deploy/rook-ceph-tools
deployment "rook-ceph-tools" successfully rolled out

root@master01-k8s-cluster:~/storage/rook/deploy/examples# kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$ ceph status
  cluster:
    id:     26e35b33-7519-4140-99a8-020c2427e42a
    health: HEALTH_WARN
            mons are allowing insecure global_id reclaim

  services:
    mon: 3 daemons, quorum a,b,c (age 90m)
    mgr: a(active, since 107m), standbys: b
    osd: 5 osds: 5 up (since 6m), 5 in (since 7m)

  data:
    pools:   1 pools, 1 pgs
    objects: 0 objects, 0 B
    usage:   25 MiB used, 800 GiB / 800 GiB avail
    pgs:     1 active+clean

[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$ 
```
```
root@master02-k8s-cluster:~# lsblk -f
NAME                      FSTYPE         LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
loop0                     squashfs                                                          0   100% /snap/core20/1361
loop1                     squashfs                                                          0   100% /snap/core20/1328
loop2                     squashfs                                                          0   100% /snap/lxd/22526
loop3                     squashfs                                                          0   100% /snap/snapd/14978
loop4                     squashfs                                                          0   100% /snap/lxd/21835
sda
├─sda1
├─sda2                    ext4                 8e4f4d32-6b82-4168-81a4-efd731ae5dea      1.3G     7% /boot
└─sda3                    LVM2_member          kwfrM9-3jOU-QRQV-I95Z-IYt2-fNnN-AKlbxv
  └─ubuntu--vg-ubuntu--lv ext4                 0839af0d-9d06-4cd5-8d9e-801f2cec4633     10.1G    59% /
sdb                       ceph_bluestore
sr0
root@master02-k8s-cluster:~#

bash: ccceph: command not found
[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$ ceph osd status
ID  HOST                                USED  AVAIL  WR OPS  WR DATA  RD OPS  RD DATA  STATE
 0  worker01-k8s-cluster.Domain.local  5188k   199G      0        0       0        0   exists,up
 1  worker03-k8s-cluster.Domain.local  5188k   199G      0        0       0        0   exists,up
 2  worker02-k8s-cluster.Domain.local  5124k   199G      0        0       0        0   exists,up
 3  master03-k8s-cluster.Domain.local  5056k  99.9G      0        0       0        0   exists,up
 4  master02-k8s-cluster.Domain.local  4996k  99.9G      0        0       0        0   exists,up
[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$ ceph df
--- RAW STORAGE ---
CLASS     SIZE    AVAIL    USED  RAW USED  %RAW USED
ssd    800 GiB  800 GiB  25 MiB    25 MiB          0
TOTAL  800 GiB  800 GiB  25 MiB    25 MiB          0

--- POOLS ---
POOL                   ID  PGS  STORED  OBJECTS  USED  %USED  MAX AVAIL
device_health_metrics   1    1     0 B        0   0 B      0    253 GiB
[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$ rados df
POOL_NAME              USED  OBJECTS  CLONES  COPIES  MISSING_ON_PRIMARY  UNFOUND  DEGRADED  RD_OPS   RD  WR_OPS   WR  USED COMPR  UNDER COMPR
device_health_metrics   0 B        0       0       0                   0        0         0       0  0 B       0  0 B         0 B          0 B

total_objects    0
total_used       25 MiB
total_avail      800 GiB
total_space      800 GiB
[rook@rook-ceph-tools-d6d7c985c-tq6sl /]$

```