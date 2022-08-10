#!/usr/bin/env bash

# Stage resources into working directory
cp -R __Pythia8CharmPileup/* .
echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export IN1_name=Pythia8CharmSignal
export IN1=(`echo $2 | tr "," " "`)
export IN2_name=Pythia8Background
export IN2=(`echo $3 | tr "," " "`)
export shrek_tag=sP22q-hfcharm-pileup-test3
export name=Pythia8CharmPileup
export build=mdc2.8
export comment=This is a test job definition
export macro=Fun4All_G4_Pileup_pp.C
export flavor=Charm
export nEvents=10
export nFiles=10
export maxAttempt=5
export memory=8192


echo START ${name} `date` 

# Initialize sPHENIX software environment
source /opt/sphenix/core/bin/sphenix_setup.sh -n ${build}

which root
root --version
root-config --features

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

tar cvf Pythia8Pileup.outDS.tar DST_*.root

echo ======================================================================================
echo Directory contents after job execution
ls -l 

echo END   ${name} `date` 

cp _${name}.log /sphenix/u/sphnxpro/shrek/${shrek_tag}-${name}-${uniqueId}.log
