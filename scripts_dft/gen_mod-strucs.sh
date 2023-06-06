#!/bin/bash

dest=mod-strucs
sys=BaCoS2
mkdir $dest
mod_dim='4 4 1'
scell_dim='4 4 1'

#for kpt in 'G0 0 0' 'X0 0.5 0';do
for kpt in 'I0.25 0.25 0';do
for idx in 1;do #  INDEX IS 1-BASED, NOT 0-BASED					                # single mode
#idx=G 											                                    # multiple modes
for disp in 0 1 5 10 20 30 40 50;do
	label=${kpt:0:1}
	coords=${kpt:1}
	conf_file=mod-$label.conf
	echo "MODULATION = $mod_dim, $coords $idx $disp" > $conf_file			        # single mode
	#echo "MODULATION = $mod_dim, $coords 1 $disp, $coords 2 $disp" > $conf_file	# multiple modes
    echo "FC_SYMMETRY = .TRUE." >> $conf_file

	phonopy --dim="$scell_dim" mod-"$label".conf
	mv MPOSCAR $dest/MPOSCAR-"$label$idx"-disp$disp.vasp
	rm $conf_file
	rm MPOSCAR-*
done
	mv MPOSCAR-orig $dest/MPOSCAR-"$label$idx"-disp0.vasp
done
done											                                    # single mode
