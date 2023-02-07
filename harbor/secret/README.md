



kubectl create secret generic [secret] --from-file=.dockerconfigjson=./.docker/config.json --type=kubernetes.io/dockerconfigjson

# Create a Secret by providing credentials on the command line
Create this Secret, naming it regcred:
```
kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```
where:

<your-registry-server> is your Private Docker Registry FQDN. Use https://index.docker.io/v1/ for DockerHub.
<your-name> is your Docker username.
<your-pword> is your Docker password.
<your-email> is your Docker email.
You have successfully set your Docker credentials in the cluster as a Secret called regcred.

```
kubectl create secret docker-registry harbor-cluster-registry-secret --docker-server=https://core-harbor-k8s-cluster.Domain.ir/dockerhub_proxy/ --docker-username=harbor_k8scluster --docker-password=Gj43TesPIM37AGy57 --docker-email=Domain.Domain@gmail.com
```
```
root@management-k8s-cluster:~/cluster/OK/secret# kubectl get secret
NAME                                TYPE                                  DATA   AGE
harbor-cluster-registry-secret       kubernetes.io/dockerconfigjson        1      11s

```
