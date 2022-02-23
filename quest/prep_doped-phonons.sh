#!/bin/bash
encut=800
suffix=fdm

echo "Don't forget to edit NELECT before submission."
#for fname in 'd0' 'd025' 'd05' 'd075' 'd1';do
for iter in '484d025' '488d05' '492d075';do
        nelect=${iter:0:3}
        fname=${iter:3}

	mkdir $fname
	cd $fname
	cp ../../shape-relax-metallic/$fname/POSCAR . 
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ../INCAR.fdm .
	cp ../KPOINTS .
	cp ~/scripts_dft/sub-static.sh .
	cp ~/scripts_dft/batch_sub-FDM.sh .
	cp ~/scripts_dft/redo-batch_sub-FDM.sh .	
	sed -i "s/encutVAR/$encut/g" INCAR.$suffix
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR.$suffix
	phonopy -d --dim='1 2 2' -c POSCAR		
	cd ..
done
