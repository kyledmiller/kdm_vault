#!/bin/bash

#Usage: First establish the appropriate files in files_dft/*compound*
#	then Call to prepare the given directory for relaxation run

suffix=frelax

# Copy over the necessary files
cp ~/files_dft/MgTa2O6/INCAR.$suffix .
cp ~/files_dft/MgTa2O6/POSCAR .
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/sub-frelax.sh .
#sed -i -e "4s/.*/$kpts/" KPOINTS

# Generate the required versions of the INCAR for each relaxation step
fname=INCAR.$suffix
sed -e "s/ISIF\s=\s../ISIF\ =\ 3\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" INCAR.$suffix > INCAR.is3.ib2
sed -e "s/ISIF\s=\s../ISIF\ =\ 3\ /" -e "s/IBRION\s=\s../IBRION\ =\ 1\ /" INCAR.$suffix > INCAR.is3.ib1

