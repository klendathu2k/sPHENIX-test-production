#!/usr/bin/env bash

echo $@
export uniqueId=$1
export IN1_name=top/outDS
export IN1=(`echo $2 | tr "," " "`)
export name=bottom
export comment=Simple example from panda


echo ${IN1[@]} > results.root
cp results.root /sphenix/u/sphnxpro/shrek/results-${uniqueId}.root 
