#!/bin/bash
src=static
nedos=3001
encut=800
emin=-8
emax=20

#for iter in '120d0' '121d025' '122d05' '123d075' '124d1' '245d0625';do
#for iter in '245d0625';do
#	nelect=${iter:0:3}
#	fname=${iter:3}
for iter in '122.6_d065' '122.8_d07' '123.2_d08' '123.4_d085';do
	nelect=${iter:0:5}
	fname=${iter:6}

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ../../$src/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.estruc INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
#sed -i "s/6 6 3/6 6 2/" d0625/KPOINTS
