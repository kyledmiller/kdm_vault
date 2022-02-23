#!/bin/bash

encut=800
#kpt='6 6 3'
nedos=3001
emin=-10
emax=14

src=static
for iter in '120d0' '121d025' '122d05' '123d075' '124d1';do
	nelect=${iter:0:3}
	fname=${iter:3}

	mkdir $fname
	cd $fname
	cp ../../$src/$fname/CHGCAR . 
	cp ../../$src/$fname/WAVECAR .
	cp ~/files_dft/MgTa2O6/INCAR.spinorb-estruc INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-ncl-static.sh .

	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
#	sed -i -e "4s/.*/$kpt/" KPOINTS
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
		
	cd ..
done
