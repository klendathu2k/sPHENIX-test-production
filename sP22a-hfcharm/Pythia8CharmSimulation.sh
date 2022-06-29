#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8CharmSimulation/* .
echo $@
export uniqueId=$1
export name=Pythia8CharmSimulation
export build=mdc2.7
export comment=Generate Pythia8 Charm Events and run through F4A
export nJobs=1
export nEvents=10
export macro=Fun4All_G4_HF_pp_signal.C
export flavor=Charm
export runnumber=1
export maxAttempt=3


echo START ${name} `date` > /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

rn=$( printf "%010d" $runnumber )
sn=$( printf "%05d"  $uniqueId )

filename=G4Hits-${flavor}-${rn}-${sn}.root
#root.exe -q -b ${macro}\($nEvents,\"${flavor}\",\"${filename}\",\"\",0,\".\"\) >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1
#ls -la ${filename} >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1


# Add output to the tar file
#tar cvf Pythia8CharmSimulation.outDS.tar ${filename}
#tar xvf Pythia8CharmSimulation.outDS.tar  >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

touch ${filename}
tar cvf Pythia8CharmSimulation.outDS.tar ${filename}

ls -la ${filename} >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

echo END   ${name} `date` 
echo END   ${name} `date` >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1
cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log
