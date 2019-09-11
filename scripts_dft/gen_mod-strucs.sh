#!/bin/bash

dest=mod-strucs
mkdir $dest

for kpt in 'G' 'R' 'X' 'Z';do
for idx in '1'; do
for disp in 5 10 15;do
	conf_file=mod-$kpt".conf"
	cp ~/files_dft/MgTa2O6/$conf_file .
	sed -i -e "s/index-flag/$idx/" $conf_file
	sed -i -e "s/disp-flag/$disp/" $conf_file
	phonopy mod-"$kpt".conf
	mv MPOSCAR-001 $dest/MPOSCAR-"$kpt$idx"-disp$disp.vasp
	rm $conf_file
done
	mv MPOSCAR-orig $dest/MPOSCAR-"$kpt$idx"-disp0.vasp
done
done
