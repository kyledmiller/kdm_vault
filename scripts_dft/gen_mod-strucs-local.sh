#!/bin/bash

dest=mod-strucs
mkdir $dest

for kpt in 'G';do
for idx in 17;do
for disp in 0 5 10 15 20 25;do
	conf_file=mod-$kpt".conf"
	#cp ~/files_dft/MgTa2O6/$conf_file .
	sed -e "s/disp-flag/$disp/g" -e "s/index-flag/$idx/g" $conf_file >> tmp-$conf_file
	phonopy tmp-$conf_file
	mv MPOSCAR $dest/MPOSCAR-dimer-disp$disp.vasp
#	rm $conf_file
done
done
done
