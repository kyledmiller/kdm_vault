#!/bin/bash

suffix=parchg
src='wavrun'

for iter in '121d025' '122d05';do
	nelect=${iter:0:3}
	fname=${iter:3}

	echo $fname
	
	mkdir $fname
	cd $fname
	cp ../INCAR.$suffix .   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	mv INCAR.$suffix INCAR
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
		
	cd ..
done
