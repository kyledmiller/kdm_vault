#!/bin/bash
src=static

#for iter in '1243' '1203-d0';do
#for iter in '120d0' '121d025' '122d05' '123d075' '124d1';do
for u1 in '1' '2' '3';do
for u2 in '2' '4';do
	nelect=${iter:0:3}
	fname=$u1-$u2

       	echo "Preparing $fname with NELECT=$nelect, U1=$u1, and U2=$u2."

	mkdir $fname
	cd $fname
	#echo "Don't forget to copy in the CHGCAR"
	#cp ../../static/$fname/CHGCAR . 
	cp ~/files_dft/MgTa2O6/INCAR.multi-hub-u-static INCAR   
	cp ../../$src/$fname/POSCAR .
	cp ../../$src/$fname/POTCAR .
	cp ../../$src/$fname/KPOINTS .
	cp ../../$src/$fname/sub-static.sh .

        sed -i "s/U-flag-1/$u1/" INCAR
	sed -i "s/U-flag-2/$u2/" INCAR
	#sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR

	#sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
	#sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
			
	cd ..
done
done
#done
