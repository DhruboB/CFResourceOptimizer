#!/bin/bash
if [ "$#" != 5 ];then
   echo "# correct command line arguments are not provided"
   echo "# invoke the shellscript by providing command line arguments e.g. ./login2Blmx.sh userid org space account apikey"
   exit 
fi
userid="$1"
stty echo
starttime=`date`
blmxorg="$2"
blmxspace="$3"
account="$4"
apikey="$5"
domreg=""
  region="ng"
  apicreg="us"
dom="mybluemix.net"

IFS="@"
set -- $userid
if [ "${#@}" -ne 2 ];then
    echo "#####################################################"
    echo "Provided IBMid is not in the format of an email"
    echo "#####################################################"
    exit
fi
unset IFS
echo
echo "#######################################################################"
echo "# Logging in to Bluemix "
bx login -a api.$region.bluemix.net -u "$userid" -o "$blmxorg" -s "$blmxspace" -c "$account" -apikey "$apikey" | tee login.out
logerr=`grep FAILED login.out | wc -l`
rm login.out
if [ $logerr -eq 1 ]; then
  echo "# Login failed... Exiting"
  exit
fi
echo "# Logged in to Bluemix ...  "
echo "#######################################################################"
