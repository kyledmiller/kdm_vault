#!/bin/bash
src=relax
for iter in '122.6_d065' '122.8_d07' '123.2_d08' '123.4_d085';do

	nelect=${iter:0:5}
	fname=${iter:6}

	mkdir $fname
	cd $fname

	cp ~/files_dft/MgTa2O6/INCAR.static INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ../sub-static.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
			
	cd ..
done
