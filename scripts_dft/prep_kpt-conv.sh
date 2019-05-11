#!/bin/bash
encut=900
var=kpt 

#for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
#for i in '4 3 2' '4 4 2' '5 4 2' '5 5 2' '5 5 3' '6 5 3' '6 6 3';
for i in '6 6 3' '7 7 3' '7 7 4' '8 8 4' '9 9 4' '9 9 5' '10 10 5';
do
        name="$(echo -e "$i" | tr -d '[:space:]')"
	mkdir "$var$name"	
        cd "$var$name"
	cp ~/files_dft/MgTa2O6/INCAR.conv INCAR   
	cp ../POSCAR POSCAR
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .
        sed -i -e "s/encutVAR/$encut/" INCAR
	sed -i "s/ISMEAR.*/ISMEAR = 0/" INCAR
	sed -i "s/#SIGMA.*/SIGMA = 0.1/" INCAR
	sed -i -e "4s/.*/$i/" KPOINTS
        cd ..
done

