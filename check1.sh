#!/bin/bash

# Master Node のインストール完了確認用のシェル (Bootstrap complete)

echo "===== start install script ====="
date
 ./openshift-install --dir=installdir wait-for bootstrap-complete --log-level=debug
echo "exit"
exit 

