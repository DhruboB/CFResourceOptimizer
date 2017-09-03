#!/bin/bash
if [ "$#" != 5 ];then
   echo "# correct command line arguments are not provided"
   echo "# invoke the shellscript by providing command line arguments e.g. ./stopResources.sh userid org space account apikey"
   exit 
fi
userid="$1"
stty echo
starttime=`date`
blmxorg="$2"
blmxspace="$3"
account="$4"
apikey="$5"

./login2Blmx.sh $userid $blmxorg $blmxspace $account $apikey

echo "# Fetching space detail from $blmxorg :"
spacelist=`bx cf spaces | awk '{if (NR>5) print $1}'`
echo "#################################################"
echo $spacelist
echo "#################################################"
for name in $spacelist 
do
  echo "entering into space $name"
  bx target -s $name
  ./stopCFApps.sh $name
  ./stopContainers.sh $name
done
