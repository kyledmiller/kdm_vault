#!/bin/bash
variable=encut
#kpts='3 5 5'

for i in $(seq 400 100 900);
do
	cd "$var$i"
	sbatch sub-static.sh
        cd ..
done

