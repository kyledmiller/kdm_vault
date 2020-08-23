#!/bin/bash

for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
	cd $fname
	sbatch sub*
	cd ..
done
