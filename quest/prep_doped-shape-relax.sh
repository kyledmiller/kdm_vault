#!/bin/bash
src=static

for iter in '122.6_d065' '122.8_d07' '123.2_d08' '123.4_d085';do
	nelect=${iter:0:5}
	fname=${iter:6}

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.relax .   
	cp ../../$src/d075/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-shape-relax-short.sh .
	cp ~/scripts_dft/prep_shape-relax.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR.relax
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	./prep_shape-relax.sh
	
	cd ..
done
