#!/bin/bash
# OCS のノードにラベルを振るシェル
oc label nodes s1.ocp45.example.localdomain cluster.ocs.openshift.io/openshift-storage=''
oc label nodes s2.ocp45.example.localdomain cluster.ocs.openshift.io/openshift-storage=''
oc label nodes s3.ocp45.example.localdomain cluster.ocs.openshift.io/openshift-storage=''
# 確認
echo check if labels are added to the node. Following nodes have been labeled for OCS install
oc get nodes -l cluster.ocs.openshift.io/openshift-storage -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}'
