#!/bin/bash

#Set Working Directory
cp POSCAR POSCAR.orig

prefix1=std-relax.out

for it in 1 2 3;do
for is in 7 2;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp POSCAR $dirName/POSCAR
cp POTCAR $dirName/POTCAR
cp KPOINTS $dirName/KPOINTS
cd $dirName/
cp POSCAR POSCAR.before
echo "Running in $dirName"
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > "$prefix1"
printf "Ran in $dirName" > CONTCAR
cp CONTCAR POSCAR.after
cp CONTCAR ../POSCAR
cd ..

done
done
done
#cp POSCAR.relaxed ~/files_dft/MgTa2O6


#Standard static calc and DOS calc
#cp INCAR.conv INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.std
#cp INCAR.dos INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.dos

