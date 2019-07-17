#!/bin/bash

suffix=wavrun
src='shape-relax-metallic'

for iter in '121d025' '122d05';do
        nelect=${iter:0:3}
        fname=${iter:3}

	mkdir $fname
	cd $fname
	cp ../INCAR.$suffix .   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	mv INCAR.$suffix INCAR
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
		
	cd ..
done
echo "Don't forget to vary to NELECT"
