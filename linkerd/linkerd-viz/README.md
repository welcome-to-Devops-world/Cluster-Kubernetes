
```
root@master01-k8s-cluster:~/cluster/linkerd/viz# ./linkerd-viz-up.sh
"linkerd" already exists with the same configuration, skipping
W0404 17:07:51.204337  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0404 17:07:51.205884  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0404 17:07:51.206234  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0404 17:07:51.206467  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0404 17:07:51.206761  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0404 17:07:51.207215  790111 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
NAME: linkerd-viz
LAST DEPLOYED: Mon Apr  4 17:07:49 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Linkerd Viz extension was successfully installed 🎉

To make sure everything works as expected, run the following:

  linkerd viz check

To view the linkerd dashboard, run the following:

  linkerd viz dashboard

Looking for more? Visit https://linkerd.io/2/getting-started/

root@master01-k8s-cluster:~/cluster/linkerd/viz# kubectl get all -n linkerd-viz
NAME                               READY   STATUS    RESTARTS   AGE
pod/grafana-68789db45b-cbtlj       2/2     Running   0          14m
pod/metrics-api-7f74d69f96-dl97r   2/2     Running   0          14m
pod/prometheus-75ff4cc4-24zsq      2/2     Running   0          14m
pod/tap-64b4fbf566-8v7mr           2/2     Running   0          14m
pod/tap-injector-9f74449fd-bhhm2   2/2     Running   0          14m
pod/web-5d6c4c6b7c-ghn5l           2/2     Running   0          14m

NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
service/grafana        ClusterIP   10.233.41.193   <none>        3000/TCP            14m
service/metrics-api    ClusterIP   10.233.60.62    <none>        8085/TCP            14m
service/prometheus     ClusterIP   10.233.26.33    <none>        9090/TCP            14m
service/tap            ClusterIP   10.233.0.81     <none>        8088/TCP,443/TCP    14m
service/tap-injector   ClusterIP   10.233.19.57    <none>        443/TCP             14m
service/web            ClusterIP   10.233.13.255   <none>        8084/TCP,9994/TCP   14m

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana        1/1     1            1           14m
deployment.apps/metrics-api    1/1     1            1           14m
deployment.apps/prometheus     1/1     1            1           14m
deployment.apps/tap            1/1     1            1           14m
deployment.apps/tap-injector   1/1     1            1           14m
deployment.apps/web            1/1     1            1           14m

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/grafana-68789db45b       1         1         1       14m
replicaset.apps/metrics-api-7f74d69f96   1         1         1       14m
replicaset.apps/prometheus-75ff4cc4      1         1         1       14m
replicaset.apps/tap-64b4fbf566           1         1         1       14m
replicaset.apps/tap-injector-9f74449fd   1         1         1       14m
replicaset.apps/web-5d6c4c6b7c           1         1         1       14m

root@master01-k8s-cluster:~/cluster/linkerd/viz#
```
