#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8CharmPileup/* .
echo $@
export uniqueId=$1
export IN1_name=Pythia8CharmSimulation/outDS
export IN1=(`echo $2 | tr "," " "`)
export IN2_name=Pythia8MinbSimulation/outDS
export IN2=(`echo $3 | tr "," " "`)
export name=Pythia8CharmPileup
export build=mdc2.7
export comment=This is a test job definition
export macro=Fun4All_G4_Pileup_pp.C
export flavor=Charm
export nEvents=1
export maxAttempt=3


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

# Input file
mcin=${IN1[0]}

echo ARGV:       $@       
echo Signal:     ${IN1[@]}  
echo Background: ${IN2[@]}

export signal=`tar xvf ${mcin}`

touch background.list
for i in "${IN2[@]}"
do
   tar xvf $i >> background.list
done

echo ======================================================================================
echo Signal: ${signal}                 
echo Background: `cat background.list` 

echo ======================================================================================
echo Directory contents before job execution
ls -l 

echo ======================================================================================
echo Executing the pileup task...

# echo arg1 \(output events\) : $1
# echo arg2 \(input file\): $2
# echo arg3 \(background listfile\): $3
# echo arg4 \(output dir\): $4
# echo arg5 \(quarkfilter\): $5
# echo arg6 \(runnumber\): $6
# echo arg7 \(sequence\): $7
# root.exe -q -b Fun4All_G4_Pileup_pp.C\($1,\"$2\",\"$3\",\"$4\",\"$5\"\)

root.exe -q -b ${macro}\(${nEvents},\"${signal}\",\"background.list\",\".\",\"${flavor}\"\)

echo ======================================================================================
echo Directory contents after job execution
ls -l 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${name}-${uniqueId}.log


# Stage everything for debugging
cp * /sphenix/u/sphnxpro/shrek/test
