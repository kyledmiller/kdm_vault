#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -J srlx               # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p normal              # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

# Retrieve POSCAR from prior run
if [ -z "$1" ]
        then
        echo "I need one argument: Directory name of run being continued, no trailing slash, assuming 2 levels above."
        exit 1
fi

prior=$1

cp ../../$prior/POSCAR .
cp ../../$prior/CHGCAR .
cp ../../$prior/WAVECAR .

cp POSCAR POSCAR.orig

outfile=std-relax.out

for it in 1 2 3;do
for is in 3;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp POSCAR $dirName/
cp POTCAR $dirName/
cp KPOINTS $dirName/
cp CHGCAR $dirName/  #continuity
cp WAVECAR $dirName/

cd $dirName/
cp POSCAR POSCAR.before
echo "Running in $dirName"
mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
cp CONTCAR POSCAR.after
cp CONTCAR ../POSCAR
cp CHGCAR ../
cp WAVECAR ../
cp OUTCAR ../final-OUTCAR
cp $outfile ../final-$outfile

cd ..
cp POSCAR final-POSCAR

done
done
done

