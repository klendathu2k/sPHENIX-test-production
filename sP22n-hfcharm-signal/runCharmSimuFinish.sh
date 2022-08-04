#!/usr/bin/env bash

echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8CharmSimu/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22n-hfcharm-signal
export name=runCharmSimuFinish
export build=mdc2.8
export comment=Finish task of the charm simulation
export maxAttempt=3


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

# Input file
mcin=${IN1[0]}

echo ARGV:       $@       
echo Signal:     ${IN1[@]}  

tar xvf ${IN1[0]}

ls -l --human-readable *.root > Pythia8CharmSimuFinish.outDS.txt

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log
