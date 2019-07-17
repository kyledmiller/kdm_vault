#!/bin/bash
src=static
encut=800
nedos=3001
emin=-10
emax=14

#for iter in '1243' '1203-d0';do
for iter in '120d0' '121d025' '122d05' '123d075' '124d1';do
for u in '1' '3';do
        nelect=${iter:0:3}
        fname=$u-${iter:3}
        
	echo "Preparing in $fname with NELECT=$nelect and U=$u."

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	cp ../../$src/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.hub-u-estruc INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ~/files_dft/MgTa2O6/POTCAR .
	cp ~/files_dft/MgTa2O6/KPOINTS .
	cp ~/scripts_dft/sub-static.sh .

        sed -i "s/U-flag/$u/" INCAR
	sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
	#sed -i "s/ISPIN = 2/ISPIN = 1/" INCAR

	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
done
