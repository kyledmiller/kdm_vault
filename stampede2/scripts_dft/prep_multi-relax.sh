#!/bin/bash

infiles='/work/06098/tg853979/stampede2/BaCoS2_follow-up/input_files'
strucs='/work/06098/tg853979/stampede2/BaCoS2_follow-up/strucs'
U=2
subfile=sub-relax-tiered-short.sh

if [ $# -eq 0 ]; then
	run=0
else
	if [ "$1" = "run" ]; then
		run=1
	fi
fi

for sym in P4nmm Pba2 P2c;do
        label=$sym
        mkdir $label
        cd $label
        cp $infiles/$subfile .
	sed -i "s/name-flag/$label/" $subfile
	sed -i "s/isif-flag/7 2/" $subfile
	cp $strucs/POSCAR-exp-$sym.vasp POSCAR
	cp $infiles/POTCAR .
        cp $infiles/KPOINTS-coarse .
	cp $infiles/KPOINTS-fine .
        cp $infiles/prep_relax.sh prep_relax.sh
	sed -i "s/isif-flag/7 2/" prep_relax.sh
        cp $infiles/INCAR.relax-coarse .
        cp $infiles/INCAR.relax-fine .
        #sed -i "s/MAGMOM = .*/MAGMOM = 8*0 4*3 4*-3 16*0/" INCAR.relax-coarse
        #sed -i "s/MAGMOM = .*/MAGMOM = 8*0 4*3 4*-3 16*0/" INCAR.relax-fine
        sed -i "s/U-flag/$U/" INCAR.relax-coarse
        sed -i "s/U-flag/$U/" INCAR.relax-fine
	
	if [ $run -eq 1 ]; then
		sbatch $subfile
	fi

        cd ..
done


