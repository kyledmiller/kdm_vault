#!/bin/bash
variable=encut
#kpts='3 5 5'

for i in $(seq 0 100 900);
do
        mkdir "$var$i"
	cp ~/files_dft/MgTa2O6/INCAR.conv "$var$i"	
	cp ~/files_dft/MgTa2O6/POSCAR "$var$i"
	cp ~/files_dft/MgTa2O6/POTCAR "$var$i"
	cp ~/files_dft/MgTa2O6/KPOINTS "$var$i"
	cp ~/scripts_dft/sub-static.sh "$var$i"
	cd "$var$i"
        sed -i -e "s/encutVAR/$i/g" INCAR.conv
        cp INCAR.conv INCAR
	#sed -i -e "4s/.*/$kpts/" KPOINTS
	sbatch sub-static.sh
        cd ..
done

