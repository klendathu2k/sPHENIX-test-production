#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8CharmSimulation/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export global_name=Pythia8Charm
export global_build=mdc2.8
export global_comment=Pythia8 Heavy Flavor (Charm) with Pileup
export global_nEvents=10


export name=Pythia8CharmSimulation
export build=mdc2.8
export comment=Generate Pythia8 Charm Events and run through F4A
export nJobs=1
export nEvents=1
export macro=Fun4All_G4_HF_pp_signal.C
export flavor=Charm
export runnumber=1
export maxAttempt=1
export memory=8192


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

echo Working directory
pwd
du --human-readable .
df --human-readable .




rn=$( printf "%010d" $runnumber )
sn=$( printf "%05d"  $uniqueId )

filename=G4Hits-${flavor}-${rn}-${sn}.root
root.exe -q -b ${macro}\($nEvents,\"${flavor}\",\"${filename}\",\"\",0,\".\"\)


# Add output to the tar file
tar cvf Pythia8CharmSimulation.outDS.tar ${filename}
ls -l

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log
