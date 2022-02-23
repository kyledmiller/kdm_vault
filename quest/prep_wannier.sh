#!/bin/bash

### Files required in $in directory ###
# POSCAR
# POTCAR
# INCAR (for each distinct run)
# KPOINTS (maybe also KPOINTS.bands)
# sub-[  ].sh
#######################################

in='/projects/p30883/anion-sub_BaCoS2/input_files'

nedos=3001
emin=-8	
emax=16

U=2

spinpol=1

w90prep=1
w90unk=1
bands=1
w90gen=1
w90run=1

seedname=wannier90
subfile=sub-wannier.sh

### Check for run command ($./prep.sh run)
if [ $# -eq 0 ]; then
        run=0
else
        if [ "$1" = "run" ]; then
                run=1
        fi
fi

### Execute preparation for each directory
for iter in Pcca_Ba4Co4S8;do
	poscar=/projects/p30883/anion-sub_BaCoS2/relax/final-POSCAR-$iter.vasp

	fname=test-pd-$iter

	mkdir $fname
	cd $fname

	cp $in/sub-wannier.sh .
        sed -i "s/w90prep=./w90prep=$w90prep/"  sub-wannier.sh
        sed -i "s/w90unk=./w90unk=$w90unk/"  	sub-wannier.sh
        sed -i "s/bands=./bands=$bands/"        sub-wannier.sh
        sed -i "s/w90gen=./w90gen=$w90gen/"  	sub-wannier.sh
        sed -i "s/w90run=./w90run=$w90run/"  	sub-wannier.sh
        sed -i "s/spinpol=./spinpol=$spinpol/"  sub-wannier.sh
	sed -i "s/name-flag/$fname/"		sub-wannier.sh


if [ $w90prep -eq 1 ]; then
	mkdir w90prep
	cd w90prep
	cp $in/INCAR.w90prep INCAR  
	sed -i "s/U-flag/$U/" INCAR
	#sed -i "s/ISPIN.*/ISPIN = 1/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
	cd ..
fi
if [ $w90unk -eq 1 ]; then
	mkdir w90unk
	cd w90unk
	cp $in/INCAR.w90run INCAR  
	echo "LWRITE_UNK = .TRUE." >> INCAR
	sed -i "s/U-flag/$U/" INCAR
	#sed -i "s/ISPIN.*/ISPIN = 1/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
	cd ..
fi
if [ $bands -eq 1 ]; then
	mkdir elec_bands
	cd elec_bands
	cp $in/INCAR.bands INCAR  
	sed -i "s/U-flag/$U/" INCAR
	#sed -i "s/ISPIN.*/ISPIN = 1/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS.bands KPOINTS
        sed -i -e "s/encutVAR/$encut/g" -e "s/nedosVAR/$nedos/g" INCAR
        sed -i -e "s/eminVAR/$emin/g" -e "s/emaxVAR/$emax/g" INCAR
	cd ..
fi

if [ $w90gen -eq 1 ]; then
	mkdir w90gen
	cd w90gen
	cp $in/eig-gen-"$seedname".win      .
	cp $in/overlap-gen-"$seedname".win  .
	cp $in/INCAR.w90run INCAR
	sed -i "s/U-flag/$U/" INCAR
	#sed -i "s/ISPIN.*/ISPIN = 1/" INCAR
	cp $poscar POSCAR
	cp $in/POTCAR-BaCoSCl POTCAR
	cp $in/KPOINTS .
	cd ..	
fi
if [ $w90run -eq 1 ]; then
	mkdir w90run
	cd w90run

	if [ $spinpol -eq 1 ]; then
		cp $in/run-"$seedname".win 	"$seedname".up.win
		echo "spin = up" >> 		"$seedname".up.win
	else
		cp $in/run-"$seedname".win 	.
	fi

	cd ..	
fi
	
#	mkdir w90dnrun
#	cd w90dnrun
#	cp ../w90run/"$seedname".dn.win "$seedname".win
#	cp ../w90run/"$seedname".dn.mmn "$seedname".mmn
#	cp ../w90run/"$seedname".dn.eig "$seedname".eig
#	cp $in/INCAR.w90run INCAR
#	sed -i "s/U-flag/$U/" INCAR
#	cp $poscar POSCAR
#	cp $in/POTCAR-BaCoSCl POTCAR
#	cp $in/KPOINTS .
#	cd ..	
#fi


if [ $run -eq 1 ]; then
	sbatch $subfile
fi

cd ..

done


