#!/bin/bash
src='../shape-relax-metallic'

#for iter in '120d0' '121d025' '122d05' '123d075' '124d1';do
for iter in '1201-d0' '1221-d05' '1241-d1';do
	nelect=${iter:0:3}
	fname=${iter:3}
	u=${iter:3:1}	
	echo "Running in $fname with NELECT=$nelect and U=$u."
	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.hub-u-relax INCAR.relax   
	cp ../../$src/${fname:2}/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-shape-relax-short.sh .
	cp ~/scripts_dft/prep_shape-relax.sh .

	sed -i "s/U-flag/$u/" INCAR.relax
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR.relax
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	./prep_shape-relax.sh
	
	cd ..
done
