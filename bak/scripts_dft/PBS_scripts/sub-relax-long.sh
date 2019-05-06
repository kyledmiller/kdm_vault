#!/bin/bash
#MSUB -l nodes=1:ppn=28
##queues: short, normal, long
#MSUB -A b1027
#MSUB -q normal
#MSUB -N MgTa2O6_rlx
#MOAB -m abe
#MOAB -M kmiller@u.northwestern.edu
#MSUB -l walltime=47:00:00

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

#Set Working Directory
cd $PBS_O_WORKDIR
cp POSCAR POSCAR.orig


#module load mpi/intel-mpi-4.1.0

#ulimit -s unlimited
#nprocs=`wc -l $PBS_NODEFILE | awk '{ print $1 }'`
echo $PBS_NODEFILE

outfile=std-relax.out

for it in 1 2 3;do
for is in 2 7;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp POSCAR $dirName/
cp POTCAR $dirName/
cp KPOINTS $dirName/
cp CHGCAR $dirName/  #continuity

cd $dirName/
cp POSCAR POSCAR.before
echo "Running in $dirName"
mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
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
#cd is2.ib1.it3
#cp POSCAR POSCAR.relaxed
#cp OUTCAR ../final-OUTCAR
#cp $outfile ../final-$outfile

#cp POSCAR.relaxed ~/files_dft/MgTa2O6


#Standard static calc and DOS calc
#cp INCAR.conv INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.std
#cp INCAR.dos INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.dos

