#!/bin/bash

kpts='3 5 5'

cp ../starting_files/INCAR.relax .
cp ../starting_files/POSCAR .
cp ../starting_files/KPOINTS .
cp ../starting_files/POTCAR .
cp /projects/b1027/KDMiller_work/scripts/gen_relax_INCARs.sh .  
cp INCAR.relax INCAR
sed -i -e "4s/.*/$kpts/" KPOINTS
./gen_relax_INCARs.sh
msub sub-relax.sh
