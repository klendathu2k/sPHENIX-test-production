#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8CharmSimulation/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export shrek_tag=sP22p-signal20
export name=Pythia8CharmSimulation
export build=mdc2.8
export comment=Generate Pythia8 Charm Events and run through F4A
export nJobs=10
export nEvents=20
export macro=Fun4All_G4_HF_pp_signal.C
export flavor=Charm
export runnumber=1
export maxAttempt=3
export memory=8192
export maxWalltime=48


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

which root
root --version
root-config --features


rn=$( printf "%010d" $runnumber )
sn=$( printf "%05d"  $uniqueId )

filename=G4Hits-${flavor}-${rn}-${sn}.root
root.exe -q -b ${macro}\($nEvents,\"${flavor}\",\"${filename}\",\"\",0,\".\"\)


# Add output to the tar file
tar cvf Pythia8CharmSimulation.outDS.tar ${filename}
ls -l

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
