#!/bin/bash

suffix=elfcar
src='shifted-static'

for iter in '122.0_d05' '122.6_d065' '124.0_d1';do
	nelect=${iter:0:5}
	fname=${iter:6}
	mkdir $fname
	cd $fname
	
	#cp ../../$src/$fname/WAVECAR .
	cp ../../$src/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/INCAR.elfcar INCAR
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ~/scripts_dft/sub-dev.sh .

	sed -i "s/name-flag/elfcar/" sub-dev.sh		
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
		
	cd ..
done
