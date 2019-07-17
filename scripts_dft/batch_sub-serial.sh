#!/bin/bash

echo "Please provide job name (must be unique for serialization to work)."
read jobName
#jobName=srlx-R1
outfile=std-serial.out

#cp POSCAR POSCAR.orig

for it in 1 2 3 4 5 6;do
for is in 3;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

# Copy in unchanging run files
cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp KPOINTS $dirName/
cp POTCAR $dirName/
cp sub-serial.sh $dirName/

cd $dirName/
#cp POSCAR POSCAR.before
echo "Running in $dirName"
sbatch --dependency=singleton --job-name=$jobName sub-serial.sh

cd ..

done
done
done

