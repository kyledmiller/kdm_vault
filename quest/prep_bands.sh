#!/bin/bash
encut=600
#kpt='3 5 5'
nedos=3001
emin=-10
emax=14

echo "Don't forget to copy in the CHGCAR"
#cp ../static/CHGCAR . 
cp ~/files_dft/MgTa2O6/INCAR.estruc .	
cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS.bands .
cp ~/scripts_dft/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR.estruc
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR.estruc
#sed -i -e "4s/.*/$kpt/" KPOINTS

cp POSCAR.relaxed POSCAR
cp KPOINTS.bands KPOINTS
cp INCAR.estruc INCAR
#msub sub-static.sh
