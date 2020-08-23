#!/bin/bash
src=shape-relax-metallic
#for iter in '120d0' '121d025' '122d05' '245d0625' '123d075' '124d1';do
	#nelect=${iter:0:3}
	#fname=${iter:3}
for fname in 'F-F' 'F-A' 'A-F' 'A-A';do
	mkdir $fname
	cd $fname
	cp ../INCAR.$fname INCAR   
	cp ../POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ../sub.sh .

	#sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
