#!/bin/bash
nedos=3001
encut=800
emin=-8
emax=20

src=fixed-vol-static
for iter in '122.6_d065' '122.8_d075' '123.4_d085' '124.0_d1';do
	nelect=${iter:0:5}
	fname=${iter:6}

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ../../$src/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.estruc INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ../../$src/$fname/sub-static.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
