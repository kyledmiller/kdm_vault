#!/bin/bash

dest=mod-strucs
sys=BaCoS2
mkdir $dest
dim='2 2 1'

for kpt in 'G0 0 0';do
for idx in 1;do #INDEX IS 1-BASED, NOT 0-BASED
for disp in 0 2 4 6 8 10;do
	label=${kpt:0:1}
	coords=${kpt:1}}
	conf_file=mod-$label.conf
	echo "MODULATION = $dim, $coords, $idx $disp" >> $conf_file

	phonopy mod-"$kpt".conf
	mv MPOSCAR $dest/MPOSCAR-"$kpt$idx"-disp$disp.vasp
	rm $conf_file
done
	mv MPOSCAR-orig $dest/MPOSCAR-"$kpt$idx"-disp0.vasp
done
done
