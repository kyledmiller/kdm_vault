#!/bin/bash
#MSUB -l nodes=1:ppn=20
##queues: short, normal, long
#MSUB -A p30625
#MSUB -q short
#MSUB -N MgTa2O6_static
#MOAB -m abe
#MOAB -M kmiller@u.northwestern.edu
#MSUB -l walltime=4:00:00

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

#Set Working Directory
cd $PBS_O_WORKDIR
#cp POSCAR POSCAR.orig

#ulimit -s unlimited
#nprocs=`wc -l $PBS_NODEFILE | awk '{ print $1 }'`
echo $PBS_NODEFILE

#Standard static calc and DOS calc
mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.std

