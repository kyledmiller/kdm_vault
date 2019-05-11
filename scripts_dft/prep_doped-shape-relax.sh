#!/bin/bash

encut="ENCUT = 900"
#nedos=3001
#emin=-8
#emax=20

for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ../../shape-relax/$fname/CHGCAR . 
	cp ../../shape-relax/$fname/INCAR.relax .   
	cp ../../shape-relax/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-shape-relax-short.sh .
	cp ../prep_shape-relax.sh .

	#mv INCAR.estruc INCAR
	sed -i "s/ENCUT.*/$encut/" INCAR.relax
	sed -i "s/ISMEAR.*/ISMEAR = 0/" INCAR.relax	
	sed -i "s/.*SIGMA.*/SIGMA = 0.1/" INCAR.relax
	#sed -i "s/#ADDGRID/ADDGRID/" INCAR.relax
	#sed -i "s/#ENAUG/ENAUG/" INCAR.relax
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
		
	cd ..
done
