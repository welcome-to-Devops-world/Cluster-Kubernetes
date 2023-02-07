

```
root@master01-k8s-cluster:~/linkerd# ./linkerd-up.sh
"linkerd" already exists with the same configuration, skipping
W0311 12:02:49.743586 1025214 warnings.go:70] batch/v1beta1 CronJob is deprecated in v1.21+, unavailable in v1.25+; use batch/v1 CronJob
W0311 12:02:49.944898 1025214 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0311 12:02:49.945816 1025214 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0311 12:02:49.946820 1025214 warnings.go:70] spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
W0311 12:02:49.952804 1025214 warnings.go:70] batch/v1beta1 CronJob is deprecated in v1.21+, unavailable in v1.25+; use batch/v1 CronJob
W0311 12:02:49.952823 1025214 warnings.go:70] spec.jobTemplate.spec.template.spec.nodeSelector[beta.kubernetes.io/os]: deprecated since v1.14; use "kubernetes.io/os" instead
NAME: linkerd2
LAST DEPLOYED: Fri Mar 11 12:02:46 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Linkerd control plane was successfully installed 🎉

To help you manage your Linkerd service mesh you can install the Linkerd CLI by running:

  curl -sL https://run.linkerd.io/install | sh

Alternatively, you can download the CLI directly via the Linkerd releases page:

  https://github.com/linkerd/linkerd2/releases/

To make sure everything works as expected, run the following:

  linkerd check

Linkerd Viz extension can be installed by running:

  linkerd viz install | kubectl apply -f -

Looking for more? Visit https://linkerd.io/2/getting-started/
```

