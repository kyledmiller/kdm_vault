#!/bin/bash

#for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
#for fname in '1-d0' '1-d05' '1-d075' '1-d1' '3-d0' '3-d05' '3-d075' '3-d1';do
for fname in 'G1' 'R1' 'X1' 'Z1';do

	cd $fname
	sbatch sub-*
	cd ..
done
