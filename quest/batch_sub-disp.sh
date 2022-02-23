#!/bin/bash

for kpt in 'X';do
for idx in 0;do
for disp in 0 4 8 12 16 20;do

fname=$kpt$idx-disp$disp

	cd $fname
	sbatch sub-*
	cd ..
done
done
done
