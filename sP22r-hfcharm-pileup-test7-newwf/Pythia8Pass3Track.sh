#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Pass3Track/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8CharmPileup/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22r-hfcharm-pileup-test7-newwf
export name=Pythia8Pass3Track
export build=ana.315
export comment=This is a test job definition
export macro=Fun4All_G4_Pass3Trk.C
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

dst_track=`ls DST_TRKR*.root`
dst_truth=`ls DST_TRUTH*.root`
outfile=dst_pass3track_output.root

#root.exe -q -b  Fun4All_G4_Pass3Trk.C\($1,\"$2\",\"$3\",\"\",\"\",0,\"$4\",\"$5\"\)
echo   root.exe -q -b  Fun4All_G4_Pass3Trk.C\($1,\"${dst_track}\",\"${dst_truth}\",\"\",\"\",0,\".\",\"${flavor}\"\)
root.exe -q -b  Fun4All_G4_Pass3Trk.C\($1,\"${dst_track}\",\"${dst_truth}\",\"\",\"\",0,\".\",\"${flavor}\"\)

# NOTE: This packs all input files as well...
tar cvf Pythia8Pass3Track.outDS.tar *.root 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
