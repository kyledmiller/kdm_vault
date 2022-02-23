#!/bin/bash
encut=800

src=static
for iter in '120.0_d0' '122.0_d05' '122.6_d065' '124.0_d1';do
	nelect=${iter:0:5}
	fname=${iter:6}

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ~/files_dft/MgTa2O6/INCAR.cohp INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	sed -i "s/encutVAR/$encut/g" INCAR
	sed -i "s/name-flag/lobster/" sub-static.sh			

	cd ..
done
