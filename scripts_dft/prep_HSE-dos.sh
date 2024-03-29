#!/bin/bash
encut=800
#kpt='3 5 5'
nedos=3001
emin=-10
emax=15

src='HSE-static'
incar='INCAR.HSE-estruc'

#echo "Don't forget to copy in the CHGCAR, POSCAR, KPOINTS"
cp ../$src/CHGCAR . 
cp ../$src/POSCAR .
cp ../$src/KPOINTS .
cp ../$src/POTCAR .
cp ~/files_dft/MgTa2O6/$incar .	
#cp ~/files_dft/MgTa2O6/POSCAR.relaxed .
#cp POSCAR.relaxed POSCAR
#cp ~/files_dft/MgTa2O6/KPOINTS .
cp ../$src/sub-static.sh .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" $incar
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" $incar
#sed -i -e "4s/.*/$kpt/" KPOINTS

mv INCAR.estruc INCAR
#msub sub-static.sh
