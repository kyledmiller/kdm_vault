#!/bin/bash

for iter in 0 2 4;do
	fname=U$iter
	echo $fname
	cd $fname
	sbatch sub-*
	cd ..
done
