#!/bin/bash
kpts='5 4 4'
sys='TaO2'

for i in $(seq 400 100 900);
do
        mkdir "$i"
	cp ~/files_dft/MgTa2O6/INCAR.conv "$i"/INCAR	
	sed -i "s/MgTa2O6/$sys/g" "$i"/INCAR	
	cp POSCAR "$i"
	cp POTCAR "$i"
	cp ~/files_dft/MgTa2O6/KPOINTS "$i"
	sed -i -e "4s/.*/$kpts/" "$i"/KPOINTS
	cp ~/scripts_dft/sub-static.sh "$i"
	cd "$i"
        sed -i -e "s/encutVAR/$i/g" INCAR
        cd ..
done

