#!/bin/bash

for disp in 0 10 20 30 40 50 60;do
	phonopy -d --dim='1 1 2' -c ../strucs/MPOSCAR-dimer-disp$disp-prim.vasp
	mv SPOSCAR POSCAR-disp$disp.vasp
done
