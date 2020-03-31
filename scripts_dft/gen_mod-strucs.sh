#!/bin/bash

dest=mod-strucs
sys=BaCoS2
mkdir $dest

for kpt in 'X';do
for idx in 1;do #INDEX IS 1-BASED, NOT 0-BASED
for disp in 0 4 8 12 16 20;do
	conf_file=mod-$kpt".conf"
	cp ~/files_dft/$sys/$conf_file .
	sed -i -e "s/disp-flag/$disp/g" $conf_file
	sed -i -e "s/index-flag/$idx/g" $conf_file
	phonopy mod-"$kpt".conf
	mv MPOSCAR $dest/MPOSCAR-"$kpt$idx"-disp$disp.vasp
	rm $conf_file
done
	mv MPOSCAR-orig $dest/MPOSCAR-"$kpt$idx"-disp0.vasp
done
done
