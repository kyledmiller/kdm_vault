#!/bin/bash
variable=encut

for i in $(seq 0 100 900);
do
        mkdir "$var$i"
        cp starting_files/* "$var$i"
        cd "$var$i"
        sed -i -e "s/encutVAR/$i/g" INCAR.conv
        cp INCAR.conv INCAR
	msub sub-conv.sh
        cd ..
done

