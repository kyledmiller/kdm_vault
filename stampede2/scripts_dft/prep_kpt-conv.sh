#!/bin/bash

### Required files ###
# POSCAR
# INCAR
# POTCAR

encut=600
var=kpt

U=2

infiles='/work/06098/tg853979/stampede2/BaCoS2_follow-up/input_files'
strucs='/work/06098/tg853979/stampede2/BaCoS2_follow-up/strucs'

for struc in 'Pba2' 'P4nmm'; do
for i in '5 5 5'; do
        name="$(echo -e " $i" | tr -s '[:space:]' '-')"
        name=${name%?} #remove trailing dash
        dirName="$struc-$var$name"
	mkdir $dirName
        cd $dirName
	echo $dirName
        cp $infiles/INCAR.static INCAR
	sed -i "s/U-flag/$U/" INCAR
        cp $strucs/POSCAR-exp-$struc POSCAR
        cp $infiles/POTCAR .
        cp $infiles/KPOINTS .
        cp $infiles/sub-static.sh .
        sed -i "s/name-flag/kpt-conv/" sub-static.sh
        sed -i -e "4s/.*/$i/" KPOINTS
	
	sbatch sub-static.sh

        cd ..
done
done
