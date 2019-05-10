#!/bin/bash

encutVAR=700
nedosVAR=3001
eminVAR=-8
emaxVAR=20

for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ../../static/$fname/CHGCAR . 
	cp ../INCAR.estruc INCAR   
	cp ../../static/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ../KPOINTS.bands KPOINTS
	cp ../sub-static.sh .

	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
		
	cd ..
done
