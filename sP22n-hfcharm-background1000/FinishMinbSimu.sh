#!/usr/bin/env bash

# Stage resources into working directory
cp -R __FinishMinbSimu/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8MinbSimulation/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22n-hfcharm-background1000
export name=FinishMinbSimu
export build=mdc2.8
export comment=This is a test job definition
export maxAttempt=5


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}


# Input file
mcin=${IN1[0]}

echo ARGV:       $@       
echo Signal:     ${IN1[@]}  

tar xvf ${mcin} > FiniahPythia8MinbSimu.outDS.txt 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
