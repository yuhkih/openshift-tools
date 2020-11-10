#!/bin/bash
# Reset baremetal install process. Replace with new install files
# All install files will be copied to nginx default directry /usr/share/nginx/html
echo "===== Start 1st half step ======"
echo "rm installdir"
rm -rf installdir/
echo "create installdir"
mkdir installdir
echo "copy install-config.yaml to installdir"
cp install-config.yaml installdir/
echo "create manifest file" 
./openshift-install create manifests --dir installdir
echo "Replacing true with false in  installdir/manifests/cluster-scheduler-02-config.yml"
sed -i -e 's/mastersSchedulable: true/mastersSchedulable: false/' installdir/manifests/cluster-scheduler-02-config.yml
echo " ===== Start latter half of steps ====="
echo "create ignition file"
 ./openshift-install create ignition-configs --dir installdir
echo "copy ignition files to ngins/html"
\cp -f ./installdir/*.ign /usr/share/nginx/html/
ls -ltr /usr/share/nginx/html/ | grep .ign
echo "===== start install script ====="
date
 ./openshift-install --dir=installdir wait-for bootstrap-complete --log-level=debug
echo "exit"
exit 

