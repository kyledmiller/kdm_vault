#!/bin/bash
variable=encut

for i in $(seq 400 100 900);
do
        mkdir "$var$i"
	cp ~/files_dft/MgTa2O6/INCAR.conv "$var$i"/INCAR	
	cp POSCAR "$var$i"
	cp ~/files_dft/MgTa2O6/POTCAR "$var$i"
	cp ~/files_dft/MgTa2O6/KPOINTS "$var$i"
	cp ~/scripts_dft/sub-static.sh "$var$i"
	cd "$var$i"
        sed -i -e "s/encutVAR/$i/g" INCAR
        cd ..
done

