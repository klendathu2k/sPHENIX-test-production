#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Calorimeter/* .
echo $@
export uniqueId=$1
export IN1_name=Pythia8CharmPileup/outDS
export IN1=(`echo $2 | tr "," " "`)
export name=Pythia8Calorimeter
export build=mdc2.8
export comment=This is a test job definition
export macro=Fun4All_G4_Calo.C
export flavor=Charm
export nEvents=1
export maxAttempt=3


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

# Input file
mcin=${IN1[0]}

echo ARGV:       $@       
echo inputs:     ${IN1[@]}  

tar xvf ${IN1[@]}

ls

touch blah.root

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log
