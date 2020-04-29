#!/bin/bash

loc='qaddr:/projects/b1027/KDMiller_work/BaCoS2/correct_mag/nelect-estruc'
prefix=U3-e
for iter in 124 125 126 127 128;do
	scp $loc/$prefix$iter/elec_dos/vasprun.xml vasprun-dos-$prefix$iter.xml	
	scp $loc/$prefix$iter/elec_bands/vasprun.xml vasprun-bands-$prefix$iter.xml
	scp $loc/$prefix$iter/static/OUTCAR OUTCAR-$prefix$iter
done
scp $loc//stats.tsv .
