#!/bin/bash
encut=700
var=kpt 

#for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
for i in '4 3 2' '4 4 2' '5 4 2' '5 5 2' '5 5 3' '6 5 3' '6 6 3';
do
        name="$(echo -e "$i" | tr -d '[:space:]')"
	mkdir "$var$name"	
        cd "$var$name"
	cp ~/files_dft/MgTa2O6/INCAR.conv INCAR   
	cp ../POSCAR POSCAR
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .
        sed -i -e "s/encutVAR/$encut/g" INCAR
	sed -i -e "4s/.*/$i/" KPOINTS
        cd ..
done

