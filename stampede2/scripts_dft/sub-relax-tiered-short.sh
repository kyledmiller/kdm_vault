#!/bin/bash
#SBATCH -A TG-DMR110085        # which account to debit hours from
#SBATCH -J name-flag               # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 4
#SBATCH --ntasks-per-node=32
#SBATCH -p normal              # queue (partition) -- normal, development, etc.
#SBATCH -t 48:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

cp POSCAR POSCAR.orig

outfile=std-relax.out

for it in 1 2 3;do
for is in isif-flag;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

if [[ $it -ge 2 ]];then
	cp KPOINTS-fine KPOINTS	
	cp INCAR.relax-fine INCAR.relax
	./prep_relax.sh
else
	cp KPOINTS-coarse KPOINTS
	cp INCAR.relax-coarse INCAR.relax
	./prep_relax.sh
fi

cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp POSCAR $dirName/
cp POTCAR $dirName/
cp KPOINTS $dirName/
cp CHGCAR $dirName/  #continuity

cd $dirName/
cp POSCAR POSCAR.before
echo "Running in $dirName"
mpirun -n $SLURM_NTASKS vasp_std > $outfile
cp CONTCAR POSCAR.after
cp CONTCAR ../POSCAR
cp CHGCAR ../
cp OUTCAR ../final-OUTCAR
cp $outfile ../final-$outfile

cd ..
cp POSCAR final-POSCAR

done
done
done

