#!/bin/bash
if [ "$#" != 1 ];then
   echo "# correct command line arguments are not provided"
   echo "# invoke the shellscript by providing command line arguments e.g. ./stopCFApps.sh space"
   exit 
fi
blmxspace="$1"
bx target -s $blmxspace | tee spacedtl.out
logerr=`grep FAILED spacedtl.out | wc -l`
rm spacedtl.out
if [ $logerr -eq 1 ]; then
  echo "# Provided Space $blmxspace could not be targeted ... Exiting"
  exit
fi

echo "# Fetching all CF apps : "
applist=`bx app list | awk '{if (NR>6) print $1}'`

echo "# Following CF apps are about to stop "
echo "#######################################################################"
echo $applist
echo "#######################################################################"
echo "Triggering stop commands for the apps"
for string in $applist 
do
    echo "stopping $string"
    bx cf stop "$string" &
    wait
done
echo "################   Script END ###################"



