#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################

in='../exp-input_files'

encut=600

nedos=3001
emin=-8	
emax=16

static=1
dos=1
bands=1

U=0

#for iter in exp;do

	#nelect=${iter:0:5}
	#fname=${iter:6}
	fname=$iter

	poscar="../../$in/POSCAR"


	cp ../$in/sub-estruc.sh .
        sed -i "s/static=./static=$static/"  sub-estruc.sh
        sed -i "s/dos=./dos=$dos/"           sub-estruc.sh
        sed -i "s/bands=./bands=$bands/"     sub-estruc.sh


if [ $static -eq 1 ]; then
	### SCF Calculation
	mkdir static
	cd static
	cp ../../$in/INCAR.static INCAR   
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
	cp ../../$in/CHGCAR .
	cd ..
fi
if [ $dos -eq 1 ]; then
	### Density of States
	mkdir elec_dos
	cd elec_dos
	cp ../../$in/INCAR.dos INCAR   
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS .
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..	
fi
if [ $bands -eq 1 ]; then
	### Band Structure
	mkdir elec_bands
	cd elec_bands
	cp ../../$in/INCAR.bands INCAR  
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp ../../$in/POTCAR .
	cp ../../$in/KPOINTS.bands KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..
fi
#done

