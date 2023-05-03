# ocp-gitops-cluster

Starting from a fresh cluster install. 

# Install OpenShift GitOps

Run `bootstrap.sh` from the `__bootstrap` directory.

# Cluster Operators





# Todo
* Secrets Management
* cert-manager


```
oc new-project reflector
helm repo add emberstack https://emberstack.github.io/helm-charts
helm repo update
helm upgrade --install reflector emberstack/reflector
oc adm policy add-scc-to-user privileged -z reflector -n reflector
```

# Notes 

## Finding Subscription Details for Operators
https://docs.openshift.com/container-platform/4.12/operators/admin/olm-adding-operators-to-cluster.html#olm-adding-operators-to-a-cluster  

```
oc get packagemanifests -n openshift-marketplace | grep <operator_name>
oc describe packagemanifests -n openshift-marketplace <operator_name>
```

# Cluster Certificate

sudo certbot -d '*.apps.ocp.snimmo.com' --manual --preferred-challenges dns certonly

sudo oc -n openshift-ingress create secret tls cluster-certs --cert=/etc/letsencrypt/live/apps.ocp.snimmo.com/fullchain.pem --key=/etc/letsencrypt/live/apps.ocp.snimmo.com/privkey.pem

oc patch --type=merge --namespace openshift-ingress-operator ingresscontrollers/default --patch '{"spec":{"defaultCertificate":{"name":"cluster-certs"}}}'

# API Certificate

sudo certbot -d 'api.ocp.snimmo.com' --manual --preferred-challenges dns certonly

sudo oc -n openshift-config create secret tls api-cert --cert=/etc/letsencrypt/live/api.ocp.snimmo.com/fullchain.pem --key=/etc/letsencrypt/live/api.ocp.snimmo.com/privkey.pem

oc patch apiserver cluster --type=merge -p '{"spec":{"servingCerts": {"namedCertificates": [{"names": ["api.ocp.snimmo.com"], "servingCertificate": {"name": "api-cert"}}]}}}' 