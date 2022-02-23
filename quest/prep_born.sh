#!/bin/bash

suffix=born
fname=born
mkdir $fname
cp POSCAR $fname
cp sub-static.sh $fname
sed -i 's/#SBATCH -J.*/#SBATCH -J born/' $fname/sub-static.sh
cp KPOINTS.$suffix $fname
cp POTCAR $fname
cp INCAR.$suffix $fname/INCAR
