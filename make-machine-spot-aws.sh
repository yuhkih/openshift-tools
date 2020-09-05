#!/bin/bash 

# export KUBECONFIG=/home/yuhki/aws_ipi/auth/kubeconfig


 # get machine set name. The result will include header line. so machineset number + 1 will be returned.
 NUMBER_OF_MSET=`oc get machinesets -n openshift-machine-api | wc -l`
 COUNTER=1

 while [ $COUNTER -lt $NUMBER_OF_MSET ]
 do
   MSET=`oc get machinesets -n openshift-machine-api | grep -v NAME | awk '{print $1}' | sed -n "$COUNTER"P`

   oc patch machineset $MSET --type='merge' --patch='{"spec":{"template":{"spec":{"providerSpec":{"value":{"spotMarketOptions":{}}}}}}}' -n openshift-machine-api

   # Scale down to 0
   oc scale machineset $MSET --replicas=0 -n openshift-machine-api
 
   # Waint until there is no "SchedulingDisabled" 
   RUNNING=`oc get nodes | grep SchedulingDisabled | wc -l`

   # Waiting loop
   while [ $RUNNING -ne 0 ]
   do
     echo "Waiting scaling down for 30 secs"
     sleep 30;
     RUNNING=`oc get nodes | grep SchedulingDisabled | wc -l`
   done

   echo "scale down completed"
   # Scale up   
   oc scale machineset $MSET --replicas=1 -n openshift-machine-api
   echo "scale up started"

   # The below value should be "1" if the machine is ready otherwise " " 
   RUNNING=`oc get machinesets -n openshift-machine-api | grep $MSET | awk '{print $4}'`

   # Waiting loop
   while [ $RUNNING != "1" ]
   do 
      echo "Waiting scaling up for 30 secs"
      sleep 30;
      RUNNING=`oc get machinesets -n openshift-machine-api | grep $MSET | awk '{print $4}'`
   done

   echo "everything done successfully" 
   let COUNTER++
   sleep 1;

 done

