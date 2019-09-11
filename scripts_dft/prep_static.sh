#!/bin/bash
src='../serial-relax'
#encut=800
#kpt='3 5 5'
#nedos=301
#emin=-8
#emax=14

cp $src/POTCAR .
cp $src/POSCAR .
cp $src/KPOINTS .
cp ~/files_dft/MgTa2O6/INCAR.static INCAR	
cp ~/scripts_dft/sub-static.sh .

#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
#sed -i -e "4s/.*/$kpt/" KPOINTS

#msub sub-static.sh
