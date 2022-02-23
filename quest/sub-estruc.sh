#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -J name-flag               # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p short              # queue (partition) -- normal, development, etc.
#SBATCH -t 04:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

#out=output_files
outfile=std.out

### Switches for calculation modules
static=1
dos=1
bands=1
parchg=1

### Static SCF Calculation
if [ $static -eq 1 ]; then
	echo 'Running SCF'
	cd static
	mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
	cd ..
fi

### Density of States
if [ $dos -eq 1 ]; then
	echo 'Running DoS'
	cd elec_dos
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
	cd ..
fi

### Band Structure
if [ $bands -eq 1 ]; then
	echo 'Running band structure'
	cd elec_bands
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
	cd ..
fi

### PARCHG generation
if [ $parchg -eq 1 ]; then
	echo 'Generation PARCHGs'
	cd parchg
	cp ../static/CHGCAR .
	cp ../static/WAVECAR .
	for iband in iband-flag;do
		mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > $outfile
		mv PARCHG PARCHG-"$iband"
	done
	cd ..
fi
