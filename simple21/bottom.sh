#!/usr/bin/env bash

echo $@
export uniqueId=$1
export IN1_name=top1/outDS
export IN1=(`echo $2 | tr "," " "`)
export IN2_name=top2/outDS
export IN2=(`echo $3 | tr "," " "`)
export name=bottom
export comment=Simple example from panda



echo ---------------------------------------------------------
echo bottom.sh:
cat bottom.sh
echo ---------------------------------------------------------

echo output:
echo ${IN1[@]}
echo ${IN2[@]}

export in1=`readlink -f ${IN1[@]}`
export in2=`readlink -f ${IN2[@]}`
export dir1=`dirname ${in1}`
export dir2=`dirname ${in2}`
echo ${dir1}
echo ${dir2}
echo "Listing directories where the files should be..."
ls -l ${dir1} ${dir2}

echo "Listing ... /home/tmp"
ls /home/tmp/

echo "Listing ... /home/tmp/atlas*/"
ls /home/tmp/atlas*/

echo "Listing ... /home/tmp/atlas*/PanDA_Pilot*/"
ls /home/tmp/atlas*/PanDA_Pilot*/

echo "Listing ... /home/tmp/atlas*/PanDA_Pilot*/user.jwebb2*"
ls /home/tmp/atlas*/PanDA_Pilot*/user.jwebb2*

touch results.root
ls > results.root

cp _${name}.log /sphenix/u/sphnxpro/shrek/_${name}-${uniqueId}.log
