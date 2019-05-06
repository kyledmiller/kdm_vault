#!/bin/bash
encut=700
#kpt='3 5 5'
nedos=301
emin=-8
emax=14

cp ~/files_dft/MgTa2O6/INCAR.static INCAR	
#cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
#cp POSCAR.relaxed POSCAR
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
#sed -i -e "4s/.*/$kpt/" KPOINTS

#msub sub-static.sh
