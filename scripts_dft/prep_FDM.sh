#!/bin/bash
encut=600
#kpt='3 5 5'
#nedos=301
#emin=-8
#emax=14

suffix=fdm

cp ~/files_dft/MgTa2O6/INCAR.$suffix .	
#cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
#cp POSCAR.relaxed POSCAR
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS.PHON .
cp ~/scripts_dft/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" INCAR.$suffix
#sed -i -e "4s/.*/$kpt/" KPOINTS

cp KPOINTS.PHON KPOINTS
cp INCAR.$suffix INCAR

if [ -e ./POSCAR-001 ]; then
	echo "Looks like you have you Phonopy files already in place."
else
	echo "Can't find Phonopy displacement files. Tsk, tsk."
	exit 1
fi

for iter in $(seq 1 9);do
	mkdir $iter
	mv POSCAR-00$iter $iter/POSCAR
	cp sub-static.sh $iter/		
	cp POTCAR $iter/
	cp KPOINTS $iter/
	cp INCAR $iter/
	cd $iter/
	msub sub-static.sh
	
	cd ..
done
