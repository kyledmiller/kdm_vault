#!/bin/bash
#MSUB -l nodes=1:ppn=24
##queues: short, normal, long
#MSUB -A p30625
#MSUB -q short
#MSUB -N MgTa2O6_frlx
#MOAB -m abe
#MOAB -M kmiller@u.northwestern.edu
#MSUB -l walltime=4:00:00

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

prefix1=std-frelax.out

for it in 1 2 3;do
for is in 3;do
for ib in 2 1;do

dirName=is"$is".ib"$ib".it"$it"
mkdir $dirName

cp INCAR.is"$is".ib"$ib" $dirName/INCAR
cp POSCAR $dirName/POSCAR
cp POTCAR $dirName/POTCAR
cp KPOINTS $dirName/KPOINTS
cd $dirName/
cp POSCAR POSCAR.before
echo "Running in $dirName"
mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > "$prefix1"
#printf "Ran in $dirName" > CONTCAR
cp CONTCAR POSCAR.after
cp CONTCAR ../POSCAR
cp WAVECAR ../
cp CHGCAR ../
cd ..

done
done
done
#cp POSCAR.relaxed ~/files_dft/MgTa2O6


#Standard static calc and DOS calc
#cp INCAR.conv INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.std
#cp INCAR.dos INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.dos
