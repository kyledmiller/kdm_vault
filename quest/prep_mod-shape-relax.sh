#!/bin/bash
src=serial-modulated-relax-d1

for iter in 'R1' 'loose-G1' 'X1' 'Z1';do

	mkdir $iter
	cd $iter
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.relax .   
	cp ../../$src/$iter/final-POSCAR POSCAR
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ../KPOINTS .
	cp ~/scripts_dft/sub-shape-relax-long.sh .
	cp ~/scripts_dft/prep_shape-relax.sh .

	sed -i "s/#NELECT-flag/NELECT = 496/" INCAR.relax
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	./prep_shape-relax.sh
	
	cd ..
done
