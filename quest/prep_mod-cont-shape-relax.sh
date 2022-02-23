#!/bin/bash

for iter in 'R1' 'G1' 'X1' 'Z1';do
	mkdir $iter
	cd $iter
	
	cp ../../$iter/INCAR.relax .
	cp ../../$iter/POTCAR .
	cp ../../$iter/KPOINTS .
	cp ../../$iter/prep_shape-relax.sh .
	./prep_shape-relax.sh

	cp ~/scripts_dft/sub-cont-shape-relax.sh .

	cd ..
done
