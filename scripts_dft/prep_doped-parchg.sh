#!/bin/bash

suffix=parchg
src='shifted-static'

#for iter in '121d025' '122d05';do
#for iter in '122.6_d065' '122.8_d07' '123.2_d08' '123.4_d085' '122.2_d055' '122.4_d06';do
#	nelect=${iter:0:5}
#	fname=${iter:6}
for iter in 'full-occ' 'part-occ';do
	nelect=122.6
	fname=d065
	echo $fname
	
	mkdir $iter
	cd $iter
	cp ../../$src/$fname/WAVECAR .
	cp ../INCAR.$suffix .   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	mv INCAR.$suffix INCAR
	
	sed -i "s/name-flag/parchg/" INCAR		
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
		
	cd ..
done
