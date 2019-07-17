#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
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

outfile=std-serial.out

# Copy in dynamic run files
cp ../POSCAR .
cp ../CHGCAR .  #continuity
cp ../WAVECAR .
cp ../POSCAR POSCAR.before

#Standard static calc and DOS calc
mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile &

# Wait for job to finish (3 hrs 50 min)
sleep 13800

# Extract continuation files
cp CONTCAR POSCAR.after
cp CONTCAR ../POSCAR
cp CONTCAR ../final-POSCAR
cp CHGCAR ../
cp WAVECAR ../
cp OUTCAR ../final-OUTCAR
cp $outfile ../final-$outfile

