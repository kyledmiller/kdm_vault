#!/bin/bash
src=shape-relax-metallic
for iter in '120d0' '121d025' '122d05' '123d075' '124d1';do
	nelect=${iter:0:3}
	fname=${iter:3}

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.spinorb-static INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-ncl-static.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
