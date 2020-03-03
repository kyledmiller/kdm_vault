#!/bin/bash

dest=mod-strucs
mkdir $dest

for kpt in 'XX';do
for idx in 1;do
for disp in 5 10 15 20 25;do
	conf_file=mod-$kpt".conf"
	cp ~/files_dft/MgTa2O6/$conf_file .
	sed -i -e "s/disp-flag/$disp/g" $conf_file
	sed -i -e "s/index-flag/$idx/g" $conf_file
	phonopy mod-"$kpt".conf
	mv MPOSCAR $dest/MPOSCAR-"$kpt"-disp$disp.vasp
	rm $conf_file
done
	mv MPOSCAR-orig $dest/MPOSCAR-"$kpt$idx"-disp0.vasp
done
done
