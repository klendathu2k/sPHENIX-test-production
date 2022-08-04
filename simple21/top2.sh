#!/usr/bin/env bash

echo $@

echo Executing on `hostname`
uname -a
lscpu | grep \^CPU
free -h --giga

export uniqueId=$1
export shrek_tag=simple21
export name=top2
export comment=Simple chain from panda examples
export nJobs=1


echo $uniqueId > seed2.txt
tar cvf top2outDS.tar seed2.txt
