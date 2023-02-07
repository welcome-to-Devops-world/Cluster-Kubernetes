
```
root@management-k8s-cluster:~/cluster/OK/grafana# ./grafana-up.sh
"grafana" already exists with the same configuration, skipping
W0416 13:05:45.234437  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.238765  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.333695  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.339397  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.346402  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.349978  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.352176  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W0416 13:05:45.355981  307586 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
NAME: grafana
LAST DEPLOYED: Sat Apr 16 13:05:44 2022
NAMESPACE: grafana
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:

   kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana.grafana.svc.cluster.local

   If you bind grafana to 80, please update values in values.yaml and reinstall:
   ```
   securityContext:
     runAsUser: 0
     runAsGroup: 0
     fsGroup: 0

   command:
   - "setcap"
   - "'cap_net_bind_service=+ep'"
   - "/usr/sbin/grafana-server &&"
   - "sh"
   - "/run.sh"
   ```
   Details refer to https://grafana.com/docs/installation/configuration/#http-port.
   Or grafana would always crash.

   From outside the cluster, the server URL(s) are:
     http://grafana-k8s-cluster.Domain.ir


3. Login with the password from step 1 and the username: admin
```
root@master01-k8s-cluster:~/cluster/grafana# kubectl get all -n grafana
NAME                           READY   STATUS    RESTARTS   AGE
pod/grafana-7989b6b847-l9szd   1/1     Running   0          25m

NAME              TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/grafana   ClusterIP   10.233.3.48   <none>        80/TCP    25m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/grafana   1/1     1            1           25m

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/grafana-7989b6b847   1         1         1       25m
root@master01-k8s-cluster:~/cluster/grafana# kubectl get pvc -n grafana
NAME      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                AGE
grafana   Bound    pvc-0375f21e-a7e8-41b3-8033-19d1eb2b15d6   10Gi       RWO            rook-cephfs-cluster-retain   25m
root@master01-k8s-cluster:~/cluster/grafana# kubectl get ingress -n grafana
NAME      CLASS   HOSTS                           ADDRESS         PORTS     AGE
grafana   nginx   grafana-k8s-cluster.Domain.ir   1.1.1.201   80, 443   25m
root@master01-k8s-cluster:~/cluster/grafana# kubectl get secret -n grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode
upVOD3vL4o1Iz9dNoyrzMu6ZfbTKLeTR8S1ff3fk
```