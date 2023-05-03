#!/bin/bash
cd "$(dirname "$0")"

oc apply -f openshift-gitops-operator-subscription.yaml
oc wait deployment -n openshift-gitops openshift-gitops-server --for condition=Available=True --timeout=90s