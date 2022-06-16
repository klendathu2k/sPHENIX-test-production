#!/usr/bin/env bash

export uniqueId=$1
export IN1_name=top1/outDS
export IN1=(`echo $2 | tr "," " "`)
export IN2_name=top2/outDS
export IN2=(`echo $3 | tr "," " "`)
export name=bottom
export comment=Simple example from panda



# Clean up 
rm /sphenix/u/sphnxpro/shrek/*

echo ---------------------------------------------------------
echo bottom.sh:
cat bottom.sh
echo ---------------------------------------------------------

echo output:
echo ${IN1[@]}
echo ${IN2[@]}

ls -l `readlink -f ${IN1[@]}`
ls -l `readlink -f ${IN2[@]}`

touch results.root
ls > results.root
#cp results.root /sphenix/u/sphnxpro/shrek/results-${uniqueId}
cp _${name}.log /sphenix/u/sphnxpro/shrek/_${name}-${uniqueId}.log
