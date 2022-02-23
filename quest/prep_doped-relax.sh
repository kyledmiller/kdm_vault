#!/bin/bash

nelect=124
for iter in '0.8' '0.85' '0.9' '0.95' '1.0' '1.05' '1.1' '1.15' '1.2';do

	mkdir $iter
	cd $iter
	cp ../INCAR.relax .   
	cp ../../strucs/POSCAR-$iter.vasp POSCAR
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ../sub-relax-short.sh .
	cp ../prep_relax.sh .

	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR.relax
			
	./prep_relax.sh
	
	cd ..
done
