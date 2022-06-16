#!/usr/bin/env bash

export uniqueId=$1
export name=top2
export comment=Simple chain from panda examples
export nJobs=2


echo $uniqueId > seed2.txt
tar cvf top2outDS.tar seed2.txt
