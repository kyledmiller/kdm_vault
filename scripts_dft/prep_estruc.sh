#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################

src=relax
in=input_files

encut=800

nedos=3001
emin=-8	
emax=16

#for iter in 0 10 20 30 40;do
for iter in 'dimer' 'no-dimer';do

	#nelect=${iter:0:5}
	#fname=${iter:6}
	fname=$iter

	poscar="../../$src/$fname/POSCAR"

	mkdir $fname
	cd $fname

	cp ../$in/sub-estruc.sh .

	### SCF Calculation
	mkdir static
	cd static
	cp ../../$in/INCAR.static INCAR   
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
	cd ..

	### Density of States
	mkdir elec_dos
	cd elec_dos
	cp ../../$in/INCAR.dos INCAR   
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..	
	
	### Band Structure
	mkdir elec_bands
	cd elec_bands
	cp ../../$in/INCAR.bands INCAR   
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS.bands KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..

	cd ..	
done

