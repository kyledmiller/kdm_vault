#!/bin/bash
#MSUB -l nodes=1:ppn=20
##queues: short, normal, long
#MSUB -A p30625
#MSUB -q short
#MSUB -N MgTa2O6_conv
#MSUB -m abe
#MSUB -M kmiller@u.northestern.edu
#MSUB -l walltime=2:00:00

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

#Set Working Directory
cd $PBS_O_WORKDIR
#cp POSCAR POSCAR.orig

#module load mpi/intel-mpi-4.1.0

#ulimit -s unlimited
#nprocs=`wc -l $PBS_NODEFILE | awk '{ print $1 }'`
echo $PBS_NODEFILE

#prefix1=rlx.out

#for it in 1 2 3
#do
#cp INCAR.is7.ib2 INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > "$prefix1".is7.ib2.$it
#cp CONTCAR POSCAR

#cp INCAR.is7.ib1 INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std  > "$prefix1".is7.ib1.$it
#cp CONTCAR POSCAR

#cp INCAR.is2.ib2 INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > "$prefix1".is2.ib2.$it
#cp CONTCAR POSCAR

#cp INCAR.is2.ib1 INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std  > "$prefix1".is2.ib1.$it
#cp CONTCAR POSCAR
#done

#Standard static calc and DOS calc
#cp INCAR.conv INCAR
mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.std
#cp INCAR.dos INCAR
#mpirun /projects/b1027/VASPmod.5.4.4/vasp_std > static-out.dos

