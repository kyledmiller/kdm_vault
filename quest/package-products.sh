#!/bin/bash

type="estruc" # Options: static, relax, estruc, w90, phon

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
    elif [ $type == static ]; then	
        cp ../$label/POSCAR POSCAR-$label.vasp
        cp ../$label/OUTCAR OUTCAR-$label
        cp ../$label/vasprun.xml vasprun-$label.xml
        cp ../$label/EIGENVAL EIGENVAL-$label
    elif [ $type == estruc ]; then
        cp ../$label/static/POSCAR POSCAR-$label.vasp
        cp ../$label/static/OUTCAR OUTCAR-$label
        cp ../$label/elec_dos/vasprun.xml vasprun-dos-$label.xml
        cp ../$label/elec_bands/vasprun.xml vasprun-bands-$label.xml
        cp ../$label/elec_dos/EIGENVAL EIGENVAL-dos-$label
        cp ../$label/elec_bands/EIGENVAL EIGENVAL-bands-$label
        #cp ../$label/static/EIGENVAL EIGENVAL-scf-$label
        #rsync -avm ../$label/parchg/PARCHG* $label/
    elif [ $type == w90 ]; then
        cp ../$label/w90prep/POSCAR POSCAR-$label.vasp
        cp ../$label/w90prep/OUTCAR OUTCAR-$label
        cp ../$label/elec_bands/vasprun.xml vasprun-bands-$label.xml
        cp ../$label/elec_bands/EIGENVAL EIGENVAL-bands-$label
        rsync -av ../$label/w90run/wannier90* --exclude '*.chk' --exclude '*mn' $label/
    elif [ $type == phon ]; then
        mkdir $label	
        cp ../$label/POSCAR $label/
        cp ../$label/SPOSCAR $label/
        cp ../$label/FORCE_SETS $label/
        cp ../$label/phonopy* $label/
        cp ../$label/irreps.yaml $label/
        cp ../$label/INCAR* $label/
        cp ../$label/INCAR $label/
        cp ../$label/KPOINTS $label/
        #rsync -av ../$label/parchg/PARCHG* $label/
        else
            echo Invalid type: $type
    fi
    shift
done
cp ../stats.tsv .
cd ..

# Packaging and compressing files
tar cvfz "$outdir".tar.gz $outdir
