#!/bin/bash

#Usage: First establish the appropriate files in files_dft/*compound*
#	then Call to prepare the given directory for relaxation run

# Copy over the necessary files
cp ~/files_dft/MgTa2O6/INCAR.relax .
cp ~/files_dft/MgTa2O6/POSCAR .
cp ~/files_dft/MgTa2O6/POTCAR .
cp ~/files_dft/MgTa2O6/KPOINTS .
cp ~/scripts_dft/sub-relax.sh .
#sed -i -e "4s/.*/$kpts/" KPOINTS

# Generate the required versions of the INCAR for each relaxation step
fname=INCAR.relax
sed -e "s/ISIF\s=\s../ISIF\ =\ 7\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" $fname > INCAR.is7.ib2
sed -e "s/ISIF\s=\s../ISIF\ =\ 7\ /" -e "s/IBRION\s=\s../IBRION\ =\ 1\ /" $fname > INCAR.is7.ib1
sed -e "s/ISIF\s=\s../ISIF\ =\ 2\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" $fname > INCAR.is2.ib2
sed -e "s/ISIF\s=\s../ISIF\ =\ 2\ /" -e "s/IBRION\s=\s../IBRION\ =\ 1\ /" $fname > INCAR.is2.ib1

