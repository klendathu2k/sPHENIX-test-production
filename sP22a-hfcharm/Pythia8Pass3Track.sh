#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Pass3Track/* .
echo $@
export uniqueId=$1
export IN1_name=Pythia8CharmPileup/outDS
export IN1=(`echo $2 | tr "," " "`)
export name=Pythia8Pass3Track
export build=mdc2.8
export comment=This is a test job definition
export macro=Fun4All_G4_Pass3Trk.C
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

# arguments 
# $1: number of events
# $2: track g4hits input file
# $3: truth g4hits input file
# $4: output dir
# $5: quark filter
# $6: run number
# $7: sequence

# DST_BBC_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_CALO_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_TRKR_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_TRUTH_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_VERTEX_pythia8_Charm_3MHz-0000000001-00001.root

dst_trkr=DST_TRKR_G4HIT*.root
dst_truth=DST_TRUTH_G4HIT*.root

echo  root.exe -q -b  ${macro}\(${nEvents},\"${dst_trkr}\",\"${dst_truth}\",\"\",\"\",0,\".\",\"${flavor}\"\)

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log
