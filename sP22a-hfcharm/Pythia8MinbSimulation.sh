#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8MinbSimulation/* .
echo $@
export uniqueId=$1
export name=Pythia8MinbSimulation
export build=mdc2.7
export comment=Generate Pythia8 Minb Events and run through F4A
export nJobs=1
export nEvents=1
export macro=Fun4All_G4_Pass1_pp.C
export flavor=ppminbias
export runnumber=1
export maxAttempt=3


echo START ${name} `date` 
echo START ${name} `date` > /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

rn=$( printf "%010d" $runnumber )
sn=$( printf "%05d"  $uniqueId )

# hepmc input data file
ln -s /sphenix/sim/sim01/sphnxpro/MDC1/pythia8_HepMC/data/*-${sn}.dat
hepmc=`ls *-${sn}.dat`

filename=G4Hits-${flavor}-${rn}-${sn}.root
echo $filename >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

#root.exe -q -b ${macro}\($nEvents,\"${hepmc}\",\"${filename}\",\"\",0,\".\"\) >& /sphenix/u/sphnxpro/PanDa/runMinbSimu-${uniqueId}.funlog

touch ${filename}
tar cvf Pythia8MinbSimulation.outDS.tar ${filename}  
#tar tvf Pythia8MinbSimulation.outDS.tar >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

echo END   ${name} `date` 
echo END   ${name} `date` >> /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log1

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log

cp * /sphenix/u/sphnxpro/shrek/minb/
