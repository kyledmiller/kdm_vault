#!/bin/bash

#for iter in '1-d0' '1-d05' '1-d1' '3-d0' '3-d05' '3-d1';do
for u in 0 1 2 3 4 5;do
	label=U$u
	scp qaddr:/projects/b1027/KDMiller_work/BaCoS2/PBESol-struc/fixed-vol-relax/$label/final-POSCAR final-POSCAR-$label.vasp
	scp qaddr:/projects/b1027/KDMiller_work/BaCoS2/PBESol-struc/fixed-vol-relax/$label/final-OUTCAR final-OUTCAR-$label

done
scp qaddr:/projects/b1027/KDMiller_work/BaCoS2/PBESol-struc/fixed-vol-relax/stats.tsv .

