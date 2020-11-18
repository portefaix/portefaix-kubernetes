# Development

For development [kind](https://kind.sigs.k8s.io/) is used.

## Cluster

Create cluster :

```shell
❯ make kind-create ENV=dev
```

Check core components:

```shell
❯ kubectl get nodes
NAME                                 STATUS   ROLES    AGE   VERSION
portefaix-local-kind-control-plane   Ready    master   95s   v1.19.1
portefaix-local-kind-worker          Ready    <none>   61s   v1.19.1

❯ kubectl get pods -A
NAMESPACE            NAME                                                         READY   STATUS    RESTARTS   AGE
kube-system          coredns-f9fd979d6-54qt2                                      1/1     Running   0          90s
kube-system          coredns-f9fd979d6-h2vsq                                      1/1     Running   0          90s
kube-system          etcd-portefaix-local-kind-control-plane                      1/1     Running   0          95s
kube-system          kindnet-9kbsd                                                1/1     Running   0          90s
kube-system          kindnet-hrfnp                                                1/1     Running   0          75s
kube-system          kube-apiserver-portefaix-local-kind-control-plane            1/1     Running   0          95s
kube-system          kube-controller-manager-portefaix-local-kind-control-plane   1/1     Running   0          95s
kube-system          kube-proxy-hs6jb                                             1/1     Running   0          90s
kube-system          kube-proxy-rrghq                                             1/1     Running   0          75s
kube-system          kube-scheduler-portefaix-local-kind-control-plane            1/1     Running   0          95s
local-path-storage   local-path-provisioner-78776bfc44-q87nb                      1/1     Running   0          90s
```

Delete cluster :

```shell
❯ make kind-delete ENV=dev
```
