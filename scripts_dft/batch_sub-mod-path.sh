#!/bin/bash
for kpt in 'R1' 'G1' 'X1' 'Z1';do
for disp in 5 10 15; do	

	iter=$kpt-disp$disp
	cd $iter
	sbatch sub-static.sh			
	cd ..
done
done
cd 'R1-disp0'
sbatch sub-static.sh
cd ..
