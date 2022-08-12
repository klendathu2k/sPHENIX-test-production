#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Pass4Track/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8Pass3Track/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22r-hfcharm-pileup-test4-oldwf
export name=Pythia8Pass4Track
export build=mdc2.8
export comment=This is a test job definition
export macro=Fun4All_G4_Trkr.C
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
# $2: tkrk hits input file
# $3: output file
# $4: output dir
# $5: quark filter
# $6: run number
# $7: sequence

dst_track=`ls DST_TRKR_HIT*.root`
dst_truth=`ls DST_TRUTH_G4HIT*.root`
outfile=dst_pass4track_output.root

echo DST_TRUTH: $dst_truth

echo root.exe -q -b Fun4All_G4_Trkr.C\(${nEvents},\"${dst_track}\",\"${outfile}\",\"\",0,\".\"\)
root.exe -q -b Fun4All_G4_Trkr.C\(${nEvents},\"${dst_track}\",\"${outfile}\",\"\",0,\".\"\)

# NOTE: This packs all input files as well...
tar cvf Pythia8Pass4Track.outDS.tar *.root 
ls 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
