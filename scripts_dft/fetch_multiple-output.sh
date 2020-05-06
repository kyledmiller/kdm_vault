#!/bin/bash

loc='qaddr:/projects/b1027/KDMiller_work/BaCoS2/correct_mag/relax'
for prefix in '' 'exp-';do
for iter in 3;do
	label="$prefix"U$iter

	scp $loc/$label/final-POSCAR final-POSCAR-$label.vasp
	scp $loc/$label/final-OUTCAR final-OUTCAR-$label

	done
done
scp $loc/stats.tsv .

