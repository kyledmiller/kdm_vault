#!/bin/bash

kpts='3 5 5'

cp ~/files_dft/MgTa2O6/INCAR.relax .   
cp ~/files_dft/MgTa2O6/POSCAR .
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/gen_relax_INCARs.sh .  
cp INCAR.relax INCAR
sed -i -e "4s/.*/$kpts/" KPOINTS
./gen_relax_INCARs.sh
msub sub-relax.sh
