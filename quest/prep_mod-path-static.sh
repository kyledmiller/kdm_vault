#!/bin/bash

if [ $# -eq 0 ]; then
        run=0
else
        if [ "$1" = "run" ]; then
                run=1
        fi
fi

in='/projects/p30883/trirutiles/MgTa2O6/input_files'
encut=800
nelect=124
subfile=sub-static.sh

for kpt in 'G1' 'G7';do
for disp in 0 5 10 15 20 25; do	
#for kpt in 'G1';do
#for disp in 15; do	

	iter=$kpt-disp$disp
	mkdir $iter
	cd $iter
	cp ../../d1/mod-strucs/MPOSCAR-$iter.vasp POSCAR
	cp $in/INCAR.static INCAR
	sed -i "s/ISPIN = 1/ISPIN = 2/" INCAR
	sed -i "s/#MAGMOM.*/MAGMOM = 18*0/" INCAR
	cp $in/POTCAR .
	cp $in/KPOINTS .
	cp $in/$subfile .
	
	sed -i "s/name-flag/path_$kpt_$disp/" sub-static.sh
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	sed -i -e "s/encutVAR/$encut/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR

        if [ $run -eq 1 ]; then
                sbatch $subfile
        fi		
	
	cd ..
done
done
