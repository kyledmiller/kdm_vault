#!/bin/bash
#SBATCH -A TG-DMR110085        # which account to debit hours from
#SBATCH -J name-flag              # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID)
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID)
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
#SBATCH -p normal             # queue (partition) -- normal, development, etc.
#SBATCH -t 8:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu
#SBATCH --mail-type=end        # email when job ends

#module load mpi/openmpi-1.6.3-intel2013.2
#module load intel/2016.0
#module load utilities
module load vasp/5.4.4

outfile=std.out

mpirun -n $SLURM_NTASKS vasp_std > $outfile

