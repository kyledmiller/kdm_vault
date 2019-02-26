#!/bin/bash
encut=600
var=kpt 

for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
do
        name="$(echo -e "$i" | tr -d '[:space:]')"
	mkdir "$var$name"
        cp ../starting_files/* "$var$name"	
        cd "$var$name"
        sed -i -e "s/encutVAR/$encut/g" INCAR.conv
	sed -i -e "4s/.*/$i/" KPOINTS
	cp INCAR.conv INCAR
	msub ../sub-conv.sh
        cd ..
done

