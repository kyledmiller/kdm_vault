#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -J MTO_static               # job name
#SBATCH -o MgTa2O6_static.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e MgTa2O6_static.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p short              # queue (partition) -- normal, development, etc.
#SBATCH -t 3:58:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

outfile=std-static.out

#Standard static calc and DOS calc
mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile

