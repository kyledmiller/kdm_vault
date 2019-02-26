#!/bin/bash
encut=600
kpt='3 5 5'
nedos=3001
emin=-10
emax=10

cp ../static/CHGCAR . 
cp ../starting_files/INCAR.estruc .	
cp ../starting_files/POSCAR.relaxed .
cp POSCAR.relaxed POSCAR
cp ../starting_files/POTCAR .
cp ../starting_files/KPOINTS .

sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR.estruc
sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR.estruc
sed -i -e "4s/.*/$kpt/" KPOINTS

cp INCAR.estruc INCAR
msub sub-static.sh
