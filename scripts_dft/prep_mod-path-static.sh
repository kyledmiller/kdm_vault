#!/bin/bash
#nelect=496
nelect=124
for kpt in 'GG';do
for disp in 5 10 15 20 25; do	

	iter=$kpt-disp$disp
	mkdir $iter
	cd $iter
	cp ~/files_dft/MgTa2O6/INCAR.static INCAR   
	cp ../MPOSCAR-$iter.vasp POSCAR
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

	sed -i "s/name-flag/mod-path/" sub-static.sh
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
done
