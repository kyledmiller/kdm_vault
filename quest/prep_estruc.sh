#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################

### Check for run command ($./prep.sh run)
if [ $# -eq 0 ]; then
        run=0
else
        if [ "$1" = "run" ]; then
                run=1
        fi
fi


in='/projects/p30883/anion-sub_BaCoS2/input_files'

subfile='sub-estruc.sh'

encut=600

nedos=3001
emin=-8
emax=16

U=0

preconv=0
static=1
dos=0
bands=0
parchg=1

ibands="61 62 63 64 65"

### Execute preparation for each directory
for iter in Pcca_Ba4Co4S8;do
        fname=$iter
        poscar=/projects/p30883/anion-sub_BaCoS2/relax/final-POSCAR-$iter.vasp

        mkdir $fname
        cd $fname

	cp $in/$subfile .
	sed -i "s/name-flag/$fname/" 	     	$subfile
        sed -i "s/preconv=.*/preconv=$static/"  $subfile
        sed -i "s/static=.*/static=$static/"  	$subfile
        sed -i "s/dos=.*/dos=$dos/"           	$subfile
        sed -i "s/bands=.*/bands=$bands/"     	$subfile
        sed -i "s/parchg=.*/parchg=$parchg/"   	$subfile
	sed -i "s/iband-flag/$ibands/"		$subfile

if [ $preconv -eq 1 ]; then
	### Preconvergent SCF Calculation
	mkdir preconv
	cd preconv
	cp $in/INCAR.preconv INCAR   
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
	cd ..
fi
if [ $static -eq 1 ]; then
	### SCF Calculation
	mkdir static
	cd static
	cp $in/INCAR.static INCAR   
        sed -i "s/ISPIN.*/ISPIN = 1/" INCAR
	sed -i "s/U-flag/$U/" INCAR 
	sed -i "s/LWAVE.*/LWAVE = .TRUE./" INCAR 
	#sed -i "/MAGMOM.*/MAGMOM = 4*0 3 -3 -3 3 8*0/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
	cd ..
fi
if [ $dos -eq 1 ]; then
	### Density of States
	mkdir elec_dos
	cd elec_dos
	cp $in/INCAR.dos INCAR   
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..	
fi
if [ $bands -eq 1 ]; then
	### Band Structure
	mkdir elec_bands
	cd elec_bands
	cp $in/INCAR.bands INCAR  
	sed -i "s/U-flag/$U/" INCAR 
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS.bands KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..
fi
if [ $parchg -eq 1 ]; then
	### PARCHG Generation
	mkdir parchg
	cd parchg
	cp $in/INCAR.parchg INCAR  
	sed -i "s/U-flag/$U/" INCAR 
	#sed -i "s/eint-flag/$eint/" INCAR
	sed -i "s/iband-flag/$iband/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..
fi

if [ $run -eq 1 ]; then
        sbatch $subfile
fi

	cd ..	
done

