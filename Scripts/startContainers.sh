#!/bin/bash
if [ "$#" != 1 ];then
   echo "# correct command line arguments are not provided"
   echo "# invoke the shellscript by providing command line arguments e.g. ./startContainers.sh space"
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

echo "# Fetching all containers : "

echo "# initializing Containers ... "
bx ic init | tee icinit.out
logerr=`grep FAILED icinit.out | wc -l`
rm icinit.out
if [ $logerr -eq 1 ]; then
  echo "# Contianer initialization failed...hence no containers in this space , skipping remaining process"
else 
  containers=`bx ic ps -a | awk '{if (NR>1) print $1}'`
  echo "# Following Containers are about to start "
  echo "#######################################################################"
  echo $containers
  echo "#######################################################################"
  echo "Triggering start commands for the containers"
  for name in $containers 
  do
    echo "starting $name"
     bx ic start $name
    wait
  done
fi
echo "################   Script END ###################"
