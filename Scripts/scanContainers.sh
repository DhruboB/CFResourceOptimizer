#!/bin/bash
rm scandtl.out
  images=`bx cr images | awk '{if (NR>3) {gsub(" ","",$1); print $1,":",$3,"!!!"}}'`; 
  echo "################   Start ###################" >>  scandtl.out
  str=`echo $images | awk '{ gsub(" ","",$0); print}'`
  echo "Triggering vulnerability scan for all images" >>  scandtl.out
  while IFS='!!!'; read -ra item ; do 
   for i in "${item[@]}"; do
   if [ -n "$i" ] && [ "$i" != "OK:" ] &&  [ "$i" != ":" ]
    then
      echo "###################################" >>  scandtl.out
      bx cr va $i >> scandtl.out
      hitcnt=`grep Critical scandtl.out | wc -l`
      #rm scandtl.out
      if [ $hitcnt -gt 0 ]; then
        echo "************** Start :: Critical issue found in image $i  ***************" >> scandtl.out
        bx cr image-inspect $i >> scandtl.out	  
        echo "************** End :: Critical issue found in image $i  ***************" >> scandtl.out
      fi
      wait
   fi  
   done
  done  <<< "$str"; 
  cat scandtl.out
echo "################   END ###################" >>  scandtl.out
