#!/bin/bash

type="w90" # Options: relax, estruc, w90

outdir=products

mkdir $outdir
cd $outdir

while [ "$1" != "" ]; do

        # Removing unwanted / from tab completion
        last="${1: -1}"
        if [ $last == "/" ]; then
                label=${1%?}
        else
                label=$1
        fi
        echo $label

        # Extracting files
        if [ $type == "relax" ]; then
                cp ../$label/final-POSCAR final-POSCAR-$label.vasp
                cp ../$label/final-OUTCAR final-OUTCAR-$label
        elif [ $type == estruc ]; then
                cp ../$label/static/POSCAR POSCAR-$label.vasp
                cp ../$label/static/OUTCAR OUTCAR-$label
                cp ../$label/elec_dos/vasprun.xml vasprun-dos-$label.xml
                cp ../$label/elec_bands/vasprun.xml vasprun-bands-$label.xml
                cp ../$label/elec_dos/EIGENVAL EIGENVAL-dos-$label
                cp ../$label/elec_bands/EIGENVAL EIGENVAL-bands-$label
                cp ../$label/static/EIGENVAL EIGENVAL-scf-$label
	elif [ $type == w90 ]; then
                cp ../$label/w90prep/POSCAR POSCAR-$label.vasp
                cp ../$label/w90prep/OUTCAR OUTCAR-$label
                cp ../$label/elec_bands/vasprun.xml vasprun-bands-$label.xml
                cp ../$label/elec_bands/EIGENVAL EIGENVAL-bands-$label
        else
                echo Invalid type: $type
        fi
        shift
done
cp ../stats.tsv .
cd ..

# Packaging and compressing files
tar cvfz "$outdir".tar.gz $outdir
