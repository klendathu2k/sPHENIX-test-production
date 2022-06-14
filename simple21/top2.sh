#!/usr/bin/env bash

export uniqueId=$1
export name=top2
export comment=Simple chain from panda examples
export nJobs=1


echo $uniqueId > seed2.txt
tar cvf top2outDS.tar seed2.txt
cp seed2.txt /sphenix/u/sphnxpro/shrek/seed2-${uniqueId}
