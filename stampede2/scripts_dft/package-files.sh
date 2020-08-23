#!/bin/bash

type="estruc" # Options: relax, estruc

outdir=products

mkdir $outdir
cd $outdir

while [ "$1" != "" ]; do
	if [ $type == "relax" ]; then
		cp ../$1/final-POSCAR final-POSCAR-$1.vasp
		cp ../$1/final-OUTCAR final-OUTCAR-$1        
	elif [ $type == estruc ]; then
		cp ../$1/static/POSCAR POSCAR-$1.vasp
		cp ../$1/static/OUTCAR OUTCAR-$1
		cp ../$1/elec_dos/vasprun.xml vasprun-dos-$1.xml
		cp ../$1/elec_bands/vasprun.xml vasprun-bands-$1.xml
		cp ../$1/elec_dos/EIGENVAL EIGENVAL-$1
	else
		echo Invalid type: $type
	fi

	shift
done

cp ../stats.tsv .

cd ..

tar cvfz "$outdir".tar.gz $outdir
