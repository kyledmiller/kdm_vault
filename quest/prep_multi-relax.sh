#!/bin/bash

infiles='../input_files'
ISIF='7'
U=0
subfile='sub-relax.sh'

if [ $# -eq 0 ]; then
        run=0
else
        if [ "$1" = "run" ]; then
                run=1
        fi
fi

for iter in '120.0d0' '122.0d05' '122.6d065' '124.0d1';do
        nelect=${iter:0:5}
        label=${iter:5}

        mkdir $label
        cd $label
        cp $infiles/$subfile .
        cp $infiles/POSCAR-relaxed-d0.vasp POSCAR
        cp $infiles/POTCAR .
        cp $infiles/KPOINTS .
        cp $infiles/prep_relax.sh prep_relax.sh
        sed -i "s/isif-flag/$ISIF/" prep_relax.sh
        sed -i "s/isif-flag/$ISIF/" $subfile

        cp $infiles/INCAR.relax .
        sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR.relax

        ./prep_relax.sh

        if [ $run -eq 1 ]; then
                sbatch $subfile
        fi

        cd ..
done
