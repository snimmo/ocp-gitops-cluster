# ocp-gitops-cluster

```
oc new-project reflector
helm repo add emberstack https://emberstack.github.io/helm-charts
helm repo update
helm upgrade --install reflector emberstack/reflector
oc adm policy add-scc-to-user privileged -z reflector -n reflector
```

