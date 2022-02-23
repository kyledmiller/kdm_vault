#!/bin/bash
#SBATCH -A p30883        # which account to debit hours from
#SBATCH -J estruc               # job name
#SBATCH -o slurm.o%j           # output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j           # output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p short              # queue (partition) -- normal, development, etc.
#SBATCH -t 04:00:00            # wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end        # email when job ends

module purge

module load mpi/openmpi-1.10.5-gcc-4.8.3
module load scalapack/2.0.2_gcc483
module load blas-lapack/3.6.0_gcc
module load fftw/3.3.3-gcc-sse2

outfile=std.out


### Switches for calculation modules
static=1
dos=0
bands=1

### Static SCF Calculation
if [ $static -eq 1 ]; then
	echo 'Running SCF'
	cd static
	mpirun -n $SLURM_NTASKS /projects/b1027/vasp.5.4.4_VTST.63_Wannier90.2.1.0_gcc_ompi/bin/vasp_ncl > $outfile
	cd ..
fi

### Density of States
if [ $dos -eq 1 ]; then
	echo 'Running DoS'
	cd elec_dos
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS /projects/b1027/vasp.5.4.4_VTST.63_Wannier90.2.1.0_gcc_ompi/bin/vasp_ncl > $outfile
	#cp vasprun.xml ../$out/vasprun-dos.xml
	cd ..
fi

### Band Structure
if [ $bands -eq 1 ]; then
	echo 'Running band structure'
	cd elec_bands
	cp ../static/CHGCAR .
	mpirun -n $SLURM_NTASKS /projects/b1027/vasp.5.4.4_VTST.63_Wannier90.2.1.0_gcc_ompi/bin/vasp_ncl > $outfile
	#cp vasprun.xml ../$out/vasprun-bands.xml
	cp KPOINTS ../$out/KPOINTS.bands
	cd ..
fi
