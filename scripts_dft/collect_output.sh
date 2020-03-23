#!/bin/bash
outdir="output_files"
mkdir $outdir
for suffix in '0' '025' '05' '065' '07' '075' '08' '085' '1';do
	cd d"$suffix"
	cp POSCAR ../$outdir/POSCAR-d$suffix.vasp
	cp final-OUTCAR ../$outdir/final-OUTCAR-d$suffix
	cd ..
done
