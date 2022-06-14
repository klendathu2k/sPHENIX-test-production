#!/usr/bin/env bash

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

echo ========== ls -la 
ls -la 

echo ========== readlink -f *

readlink -f *

echo ========== ls -la `readlink -f *top1outDS*`    

ls -la `readlink -f *top1outDS*`

echo ========== ls -la just the path

export fullpath=`readlink -f *top1outDS*`
export dirpath=`dirname ${fullpath}`

ls -la $dirpath

echo ========== ls -l just the path plus the panda pilot directory

ls -la $dirpath/PanDA*/

echo ==========

tar tvzf `readlink -f *top1outDS*`

echo ==========

touch results.root
cp results.root /sphenix/u/sphnxpro/shrek/results-${uniqueId}
cp _${name}.log /sphenix/u/sphnxpro/shrek/_${name}-${uniqueId}.log
