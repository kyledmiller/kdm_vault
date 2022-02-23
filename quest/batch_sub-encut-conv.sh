#!/bin/bash

for i in $(seq 400 100 900);
do
	cd "$i"
	sbatch sub-static.sh
        cd ..
done

