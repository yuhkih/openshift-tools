
echo "check the number of Pending"
NUMBER=`oc get csr | grep Pending | wc -l`
echo There are $NUMBER Peinding CSRs
echo Approve CSRs
oc get csr -o go-template='{{range .items}}{{if not .status}}{{.metadata.name}}{{"\n"}}{{end}}{{end}}' | xargs oc adm certificate approve

