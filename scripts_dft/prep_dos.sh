#!/bin/bash
encut=800
#kpt='3 5 5'
nedos=3001
emin=-10
emax=15

#echo "Don't forget to copy in the CHGCAR, POSCAR, KPOINTS"
cp ../static/CHGCAR . 
cp ../static/POSCAR .
cp ../static/KPOINTS .
cp ~/files_dft/MgTa2O6/INCAR.estruc .	
#cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
#cp POSCAR.relaxed POSCAR
cp ~/files_dft/MgTa2O6/POTCAR .
#cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR.estruc
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR.estruc
#sed -i -e "4s/.*/$kpt/" KPOINTS

mv INCAR.estruc INCAR
#msub sub-static.sh
