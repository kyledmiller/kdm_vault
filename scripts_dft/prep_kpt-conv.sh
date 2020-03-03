#!/bin/bash

### Required files ###
# POSCAR
# INCAR
# POTCAR

encut=800
var=kpt 

#for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
#for i in '4 3 2' '4 4 2' '5 4 2' '5 5 2' '5 5 3' '6 5 3' '6 6 3';
#for i in '3 3 3' '5 5 5' '7 7 7' '9 9 9' '11 11 11' '13 13 13';
for i in '7 2 5' '8 3 5' ' 8 3 6' '9 3 7' '11 4 7' '11 4 8'
do
        name="$(echo -e " $i" | tr -s '[:space:]' '-')"
	name=${name%?} #remove trailing dash
	mkdir "$var$name"	
        cd "$var$name"
	cp ../INCAR .   
	cp ../POSCAR .
	cp ../POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .
	sed -i "s/name-flag/kpt-conv/" sub-static.sh
        sed -i -e "s/encutVAR/$encut/" INCAR
	sed -i "s/ISMEAR.*/ISMEAR = 0/" INCAR
	sed -i "s/#SIGMA.*/SIGMA = 0.1/" INCAR
	sed -i -e "4s/.*/$i/" KPOINTS
        cd ..
done

