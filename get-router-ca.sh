#!/bin/sh
oc get secret router-ca -n openshift-ingress-operator -o jsonpath="{.data.tls\.crt}" | base64 -d > router-ca.crt 
echo router-ca.crt created
