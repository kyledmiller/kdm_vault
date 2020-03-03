#!/bin/bash
encut=600

src='static'
incar='INCAR.HSE-static'

for iter in '120.0_d0' '121.0_d025' '122.0_d05' '122.6_d065' '123.0_d075' '124.0_d1';do
        nelect=${iter:0:5}
        fname=${iter:6}
	
	mkdir $fname
	cd $fname

	#echo "Don't forget to copy in the CHGCAR, POSCAR, KPOINTS"
	cp ../../$src/$fname/CHGCAR . 
	cp ../../$src/$fname/WAVECAR .
	cp ../../$src/$fname/POSCAR .
	cp ../KPOINTS .
	cp ../../$src/$fname/POTCAR .
	cp ~/files_dft/MgTa2O6/$incar .	
	cp ../sub-static.sh .
	
	sed -i "s/#NELECT-flag/NELECT = $nelect/" $incar
	sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" $incar
	sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" $incar
	#sed -i -e "4s/.*/$kpt/" KPOINTS
	
	mv $incar INCAR
	cd ..
done
