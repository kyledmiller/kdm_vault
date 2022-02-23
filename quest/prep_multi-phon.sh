#!/bin/bash

### Files required in $in directory ###
# POSCAR* -- or define $poscar
# POTCAR
# INCAR.fdm
# KPOINTS.phon
# sub-static.sh
# prep_FDM.sh
# batch_sub-FDM.sh
#######################################

infiles='/projects/p30883/ml-trirutiles/input_files'
dim='1 1 1'
amp=0.01

for dir in $infiles/*/; do
        compound=${dir:43:-1}
        echo $compound

        mkdir $compound
        cd $compound
        cp "$dir"POSCAR .
        cp "$dir"POTCAR .
        cp "$dir"INCAR .
	printf "ICHARG = 1\n" >> INCAR
	printf "\nLWAVE = .FALSE.\nLCHARG = .FALSE.\n" >> INCAR
	printf "\nNPAR = 4\nKPAR = 4\n" >> INCAR
	printf "\nAMIX = 0.2\nBMIX = 0.0001\nAMIX_MAG = 0.8\nBMIX_MAG = 0.0001" >> INCAR

	cp $infiles/KPOINTS KPOINTS
	cp $infiles/sub-static.sh .
        sed -i "s/name-flag/phon-$compound-name-flag/" sub-static.sh	
	cp $infiles/prep_FDM.sh .
	cp $infiles/batch_sub-FDM.sh .

	#phonopy -d --dim="$dim" --amplitude=$amp --tolerance=1e-4  -c POSCAR

	./prep_FDM.sh 9
	
	cd ..
done

#for iter in ;do
#        nelect=${iter:0:3}
#        fname=${iter:3}
#        poscar="../../relax/$fname/POSCAR"

#	mkdir $fname
#	cd $fname

#	cp $in/INCAR.fdm INCAR
	#sed -i "s/U-flag/$U/" INCAR
#        sed -i "s/encutVAR/$encut/g" INCAR
#        sed -i "s/#NELECT-flag/NELECT = $nelect/" INCAR
#	cp $poscar POSCAR
#	cp $in/POTCAR .
#	cp $in/prep_FDM.sh .
#	cp $in/batch_sub-FDM.sh .
#	cp $in/sub-static.sh sub-static.sh

#	phonopy -d --dim="$dim" --amplitude=$amp --tolerance=1e-4  -c POSCAR

        #sed -i 's/MAGMOM.*/MAGMOM = 8*0 -3 3 3 -3 -3 3 3 -3 16*0/' INCAR.fdm

#	./prep_FDM.sh 9
	
#	cd unmod
#	sbatch sub-static.sh
#	cd ..

#	cd ..
#done

