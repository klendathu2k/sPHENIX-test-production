#!/usr/bin/env bash

echo $@
export uniqueId=$1
export name=top
export comment=Simple chain from panda examples
export nJobs=3


echo $uniqueId > seed.txt
cp seed.txt /sphenix/u/sphnxpro/shrek/seed-${uniqueId}.txt
