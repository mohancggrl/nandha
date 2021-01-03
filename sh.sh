#!/bin/bash
wsp="/tmp/nandha"
dt="/tmp/mohan"
cd $wsp
env1="$wsp/db/package/ec20.5/prod"
env2="$wsp/db/package/ec20.5/preprod"
env3="$wsp/db/package/ec20.5/qa"
env4="$wsp/db/package/ec20.5/uat"
mkdir -p $wsp/db/package/ec20.5/{prod,preprod,uat,qa}
#chown -R jenkins:jenkins $wsp/package/*
chmod -R 777 $wsp/db/package/*
list=`ls /tmp/mohan/`
for filename in $list;
do
 IFS='-' read -ra ADDR <<< "$filename"
 a=${ADDR[-1]}
 IFS='.' read -ra AD <<< "$a"
 b=${AD[0]}
# for pr in $b;
   #echo $b
 if [ "$b" == "prod" ];
 then
   #echo $filename 1
   mv  $dt/$filename $env1
 elif [ "$b" == "prepod" ];
 then
   #echo $filename 2
   mv  $dt/$filename $env2
 elif [ "$b" == "qc" ];
 then
   #echo $filename 3
   mv  $dt/$filename $env3
 elif [ "$b" == "uat" ];
 then
   #echo $filename 4
   mv  $dt/$filename $env4
 else
   #echo $filename 5
   #cp -f $dt/$filename {$env1,$env2,$env3,$env4}
   xargs -n 1 cp -v $dt/$filename<<<"$env1 $env2 $env3 $env4"
   mv 
 fi
done
