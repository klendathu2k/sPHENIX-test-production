#!/usr/bin/env bash

echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export name=top
export comment=Simple chain from panda examples
export nJobs=3


echo $uniqueId > seed.txt
cp seed.txt /sphenix/u/sphnxpro/PanDa/
