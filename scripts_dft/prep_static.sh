#!/bin/bash
encut=600
#kpt='3 5 5'
nedos=301
emin=-8
emax=14

cp ~/files_dft/MgTa2O6/INCAR.static .	
cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
cp POSCAR.relaxed POSCAR
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR.static
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR.static
#sed -i -e "4s/.*/$kpt/" KPOINTS

cp INCAR.static INCAR
#msub sub-static.sh
