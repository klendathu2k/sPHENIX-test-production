#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8Pass4TrackStageC/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8Pass4TrackStageA/outDS
export IN1=(`echo $2 | tr "," " "`)
export shrek_tag=sP22r-hfcharm-pileup-test10-newwf
export name=Pythia8Pass4TrackStageC
export build=ana.315
export comment=This is a test job definition
export macro=Fun4All_G4_sPHENIX_jobC.C
export flavor=Charm
export nEvents=10
export maxAttempt=None
export runnumber=1


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

rn=$( printf "%010d" $runnumber )
sn=$( printf "%05d"  $uniqueId )

dst_track=`ls DST_TRKR_HIT*.root`
dst_truth=`ls DST_TRUTH_G4HIT*.root`
outfile=HF_pp200_signal_pass4_jobC_${rn}

echo DST_TRUTH: $dst_truth

#echo root.exe -q -b ${macro}\(${nEvents},\"${dst_track}\",\"${outfile}\",\"\",0,\".\"\)
#root.exe -q -b ${macro}\(${nEvents},\"${dst_track}\",\"${outfile}\",\"\",0,\".\"\)

echo root.exe -q -b ${macro}\(${nEvents},0,\"${dst_track}\",\"${outfile}\",\".\"\)
root.exe -q -b ${macro}\(${nEvents},0,\"${dst_track}\",\"${outfile}\",\".\"\)

# NOTE: This packs all input files as well...
tar cvf Pythia8Pass4TrackStageC.outDS.tar *.root 
ls 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
