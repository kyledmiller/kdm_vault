#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -J static               # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p short              # queue (partition) -- normal, development, etc.
#SBATCH -t 3:58:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module purge

module load mpi/openmpi-1.10.5-gcc-4.8.3
module load scalapack/2.0.2_gcc483
module load blas-lapack/3.6.0_gcc
module load fftw/3.3.3-gcc-sse2

outfile=std-static.out

#Standard static calc and DOS calc
mpirun -n $SLURM_NTASKS /projects/b1027/vasp.5.4.4_VTST.63_Wannier90.2.1.0_gcc_ompi/bin/vasp_ncl > $outfile


