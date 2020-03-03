#!/bin/bash

suffix=fdm

if [ -z "$1" ]
	then
	echo "I need one argument: how many displacements there are."
	exit 1
fi

numdisp=$1


#cp INCAR.$suffix INCAR

#if [ -e ./POSCAR-001 ]; then
#	echo "Looks like you have you Phonopy files already in place. Moving on..."
#else
#	echo "Can't find Phonopy displacement files. Tsk, tsk."
#	exit 1
#fi

for iter in $(seq 1 $numdisp);do
	mkdir $iter
	if [ $iter -gt 9 ]; then
		mv POSCAR-0$iter $iter/POSCAR
	else
		mv POSCAR-00$iter $iter/POSCAR
	fi
	cp sub-static.sh $iter/		
	cp POTCAR $iter/
	cp KPOINTS $iter/
	cp INCAR.$suffix $iter/INCAR
	cp CHGCAR $iter
done

noDisp=unmod
mkdir $noDisp
cp SPOSCAR $noDisp/POSCAR
cp sub-static.sh $noDisp
cp KPOINTS $noDisp
cp POTCAR $noDisp
cp INCAR.$suffix $noDisp/INCAR
sed -i 's/LCHARG = .FALSE./LCHARG = .TRUE./' $noDisp/INCAR
