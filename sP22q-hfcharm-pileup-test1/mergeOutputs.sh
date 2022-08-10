#!/usr/bin/env bash

echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8Calorimeter/outDS
export IN1=(`echo $2 | tr "," " "`)
export IN2_name=Pythia8Pass4Track/outDS
export IN2=(`echo $3 | tr "," " "`)
export shrek_tag=sP22q-hfcharm-pileup-test1
export name=mergeOutputs
export build=mdc2.8
export comment=Merge all outputs into a single tarball
export maxAttempt=3


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

# Input file
mcin=${IN1[0]}

echo ARGV:       $@       
echo Signal:     ${IN1[@]}  
echo Background: ${IN2[@]}

tar xvf ${IN1[0]}
tar xvf ${IN2[0]}

# Pack everything up...
tar cvf Pythia8CharmOutput.outDS.tar *.root

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
