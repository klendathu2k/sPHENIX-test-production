#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Calorimeter/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8CharmPileup/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22r-hfcharm-pileup-test9-newwf
export name=Pythia8Calorimeter
export build=ana.315
export comment=This is a test job definition
export macro=Fun4All_G4_Calo.C
export flavor=Charm
export nEvents=10
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
# $2: calo g4hits input file
# $3: vertex input file
# $4: output file
# $5: output dir
# $6: quark filter
# $7: run number
# $8: sequence

# DST_BBC_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_CALO_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_TRKR_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_TRUTH_G4HIT_pythia8_Charm_3MHz-0000000001-00001.root
# DST_VERTEX_pythia8_Charm_3MHz-0000000001-00001.root

dst_calo=`ls DST_CALO_G4HIT*.root`
dst_vert=`ls DST_VERTEX*.root`
outfile=dst_calo_output.root

root.exe -q -b  ${macro}\(${nEvents},\"${dst_calo}\",\"${dst_vert}\",\"${outfile}\",\".\"\)

# NOTE: This packs all input files as well...
tar cvf Pythia8Calorimeter.outDS.tar *.root 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
