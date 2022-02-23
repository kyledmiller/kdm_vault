#!/bin/bash

### Required files ###
# POSCAR
# INCAR
# POTCAR

### Check for run command ($./prep.sh run)
if [ $# -eq 0 ]; then
        run=0
else
        if [ "$1" = "run" ]; then
                run=1
        fi
fi

in=../../input_files
subfile=sub-static.sh

encut=600
U=2
var=kpt 

for i in '4 4 2' '4 4 3' '5 5 3' '5 5 4' '6 5 4' '6 6 4' '6 6 5'
do
        name="$(echo -e " $i" | tr -s '[:space:]' '-')"
	name=${name%?} #remove trailing dash
	mkdir "$var$name"	
        cd "$var$name"
	cp $in/INCAR.static INCAR
        sed -i "s/encutVAR/$encut/" INCAR
	sed -i "s/U-flag/$U/" INCAR
	cp $in/POSCAR-Pcca.vasp POSCAR
	cp $in/POTCAR .
	cp $in/KPOINTS.Pcca KPOINTS
	sed -i "4s/.*/$i/" KPOINTS
	cp $in/$subfile .
	sed -i "s/name-flag/$var$name/" $subfile

        if [ $run -eq 1 ]; then
                sbatch $subfile
        fi

        cd ..
done

