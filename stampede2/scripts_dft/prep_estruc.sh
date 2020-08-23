#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################

in='/work/06098/tg853979/stampede2/BaCoS2_follow-up/input_files'
strucs='/work/06098/tg853979/stampede2/BaCoS2_follow-up/strucs'
subfile=sub-estruc.sh

encut=600

nedos=3001
emin=-8
emax=16

static=1
dos=1
bands=0

U=2

### Check for run command ($./prep.sh run)
if [ $# -eq 0 ]; then
	run=0
else
	if [ "$1" = "run" ]; then
		run=1
	fi
fi


for iter in P4nmm Pba2 P2c;do
for p in 0 5 10 15 20; do
#for p in 0; do
        #nelect=${iter:0:5}
        #fname=${iter:6}
        fname=struc_"$iter"_p"$p"

        #poscar=$strucs/POSCAR-relaxed-$iter
	poscar=../../../press-relax/struc_"$iter"_p"$p"/final-POSCAR

        mkdir $fname
        cd $fname

        cp $in/$subfile .
        sed -i "s/static=./static=$static/"  	$subfile
        sed -i "s/dos=./dos=$dos/"           	$subfile
        sed -i "s/bands=./bands=$bands/"     	$subfile
        sed -i "s/name-flag/$fname/" 		$subfile


if [ $static -eq 1 ]; then
        ### SCF Calculation
        mkdir static
        cd static
        cp $in/INCAR.static INCAR
        sed -i "s/U-flag/$U/" INCAR
        echo "PSTRESS = $p" >> INCAR
        cp $poscar POSCAR
        cp $in/POTCAR .
        cp $in/KPOINTS .
        cp $in/CHGCAR .
        cd ..
fi
if [ $dos -eq 1 ]; then
        ### Density of States
        mkdir elec_dos
        cd elec_dos
        cp $in/INCAR.dos INCAR
        sed -i "s/U-flag/$U/" INCAR
        echo "PSTRESS = $p" >> INCAR
        cp $poscar POSCAR
        cp $in/POTCAR .
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
        echo "PSTRESS = $p" >> INCAR
        cp $poscar POSCAR
        cp $in/POTCAR .
        cp $in/KPOINTS.bands KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
        cd ..
fi
	if [ $run -eq 1 ]; then
		sbatch $subfile
	fi
        
	cd ..
done
done
