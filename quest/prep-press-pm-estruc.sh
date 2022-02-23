#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (.static, .dos, .bands)
# KPOINTS
# KPOINTS.bands
# sub-estruc.sh
#######################################
in='/projects/b1027/KDMiller_work/BaCoS2_follow-up/input_files/SQS-conv'
subfile=sub-estruc.sh

encut=600

nedos=3001
emin=-3
emax=11

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


#for sym in P4nmm Pba2 P2c;do
#for p in 5 10 15 20 2;do
for sym in P4nmm;do
for p in 5;do
        label="$sym"_p"$p"
        fname=struc_$label

        poscar=../../../press-pm-is7-relax/$fname/final-POSCAR
        chgcar=../../../press-pm-is7-relax/$fname/CHGCAR

        kpoints="$in"/KPOINTS.coarse
        doskpoints="$in"/KPOINTS.coarse

        if [ $sym == P2c ]; then
                doskpoints="$in"/KPOINTS.P2c
        fi

        mkdir $fname
        cd $fname

        cp $in/$subfile .
	sed -i "s/name-flag/$label/"	     $subfile
        sed -i "s/static=./static=$static/"  $subfile
        sed -i "s/dos=./dos=$dos/"           $subfile
        sed -i "s/bands=./bands=$bands/"     $subfile


if [ $static -eq 1 ]; then
        ### SCF Calculation
        mkdir static
        cd static
        cp $chgcar CHGCAR
        cp $in/INCAR.static INCAR
        sed -i "s/U-flag/$U/" INCAR
        sed -i "s/#magmom-flag-$label//" INCAR
        echo "PSTRESS = $p" >> INCAR
        cp $poscar POSCAR
        cp $in/POTCAR .
        cp $kpoints KPOINTS
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
        cp $doskpoints KPOINTS
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
