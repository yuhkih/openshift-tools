#!/bin/bash

# OpenShift  のインストール完了確認シェル

echo "===== start install script ====="
date
./openshift-install --dir=installdir wait-for install-complete
echo "exit"
exit 

