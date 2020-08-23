#!/bin/bash
#SBATCH -A TG-DMR110085        # which account to debit hours from
#SBATCH -J estruc              # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID)
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID)
#SBATCH -N 2
#SBATCH --ntasks-per-node=32
#SBATCH -p development             # queue (partition) -- normal, development, etc.
#SBATCH -t 2:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu
#SBATCH --mail-type=end        # email when job ends

#module load mpi/openmpi-1.6.3-intel2013.2
#module load intel/2016.0
#module load utilities
module load vasp/5.4.4

outfile=std.out

vasp=vasp_std

### Switches for calculation modules
static=1
dos=1
bands=1

### Static SCF Calculation
if [ $static -eq 1 ]; then
	echo 'Running SCF'
	cd static
	mpirun -n $SLURM_NTASKS $vasp > $outfile
	cd ..
fi

### Density of States
if [ $dos -eq 1 ]; then
	echo 'Running DoS'
	cd elec_dos
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS $vasp > $outfile
	#cp vasprun.xml ../$out/vasprun-dos.xml
	cd ..
fi

### Band Structure
if [ $bands -eq 1 ]; then
	echo 'Running band structure'
	cd elec_bands
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS $vasp > $outfile
	#cp vasprun.xml ../$out/vasprun-bands.xml
	cp KPOINTS ../$out/KPOINTS.bands
	cd ..
fi
