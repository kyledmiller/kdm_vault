#!/bin/bash

for fname in 'F-F' 'F-A' 'A-F' 'A-A';do
	cd $fname
	sbatch sub*
	cd ..
done
