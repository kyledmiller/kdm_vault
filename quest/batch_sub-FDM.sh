#!/bin/bash

suffix=fdm

if [ -z "$1" ]
	then
	echo "I need one argument: how many displacements there are."
	exit 1
fi

numdisp=$1

for iter in $(seq 1 $numdisp);do
	cd $iter/
	sbatch sub-static.sh
	cd ..
done
