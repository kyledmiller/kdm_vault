#!/bin/bash

for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ../INCAR.static INCAR   
	cp ../../relax/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	#mv INCAR.static INCAR
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
		
	cd ..
done
echo "Don't forget to vary to NELECT"
