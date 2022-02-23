#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################

in='../input_files'

encut=600

nedos=3001
emin=-8	
emax=16

static=1
dos=1
bands=0

#for iter in 0 10 20 30 40;do
for iter in 'og' '5a' 'dft';do
for u in 1 3 5;do
	#nelect=${iter:0:5}
	#fname=${iter:6}
	fname=$iter-U$u

	poscar="../../$in/POSCAR-$iter"

	mkdir $fname
	cd $fname

	cp ../$in/sub-estruc.sh .

	### SCF Calculation
	if [ $static -eq 1 ]; then
	mkdir static
	cd static
	cp ../../$in/INCAR.hub-u-static INCAR   
        sed -i "s/U-flag/$u/" INCAR	
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
	cd ..
	fi

	### Density of States
	if [ $dos -eq 1 ]; then
	mkdir elec_dos
	cd elec_dos
	cp ../../$in/INCAR.hub-u-dos INCAR   
        sed -i "s/U-flag/$u/" INCAR	
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..	
	fi

	#if [ $bands -eq 1 ]; then
	#	### Band Structure
	#	mkdir elec_bands
	#	cd elec_bands
	#	cp ../../$in/INCAR.bands INCAR   
	#	cp $poscar POSCAR
	#	cp ../../$in/POTCAR .
	#	cp ../../$in/KPOINTS.bands KPOINTS
	#        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	#	cd ..
	#fi

	cd ..	
done
done
