#!/bin/bash
src=relax

for iter in '0.083' '0.167';do
	fname=$iter

	mkdir $fname
	cd $fname
	
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ../INCAR.static INCAR   
	cp ../sub-static.sh .
	
	cd ..
done
