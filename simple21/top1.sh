#!/usr/bin/env bash

echo $@
export uniqueId=$1
export name=top1
export comment=Simple chain from panda examples
export nJobs=1


echo $uniqueId > seed1.txt
tar cvf top1outDS.tar seed1.txt
