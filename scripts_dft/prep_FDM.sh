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

