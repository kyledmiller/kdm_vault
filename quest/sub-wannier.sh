#!/bin/bash
#SBATCH -A p30883		# which account to debit hours from
#SBATCH -J name-flag		# job name
#SBATCH -o slurm.o%j		# output and error file name (%j expands to jobID) 
#SBATCH -e slurm.e%j		# output and error file name (%j expands to jobID) 
#SBATCH -N 1
#SBATCH --ntasks-per-node=28
#SBATCH -p short		# queue (partition) -- normal, development, etc.
#SBATCH -t 04:00:00		# wall time (hh:mm:ss)
#SBATCH --mail-user=kmiller@u.northwestern.edu 
#SBATCH --mail-type=end		# email when job ends

module load mpi/openmpi-1.6.3-intel2013.2
module load intel/2016.0
module load utilities
module load python

seedname=wannier90

outfile=std.out
vasp='/projects/b1027/VASPmod.5.4.4/vasp_std'
vasp_w90='/projects/b1027/VASPwannier90.5.4.4/vasp.5.4.4/build/std/vasp'
w90="/projects/b1027/VASPwannier90.5.4.4/wannier90-2.1.0/wannier90.x"

### Switches for calculation modules
spinpol=1
calcdn=1

w90prep=0
w90unk=0
bands=0
w90gen=1
w90run=1

### Static SCF Calculation to generate WAVECAR for w90
if [ $w90prep -eq 1 ]; then
	echo 'Running Wannier90 prep'
	cd w90prep
	mpirun -n $SLURM_NTASKS $vasp > $outfile
	cd ..
fi

### Static SCF Calculation to generate UNK files for w90
if [ $w90unk -eq 1 ]; then
	echo 'Running Wannier90 unk'
	source /opt/intel/composer_xe_2016/compilers_and_libraries_2016.4.258/linux/bin/compilervars.sh intel64
	module load mpi/intel-mpi-5.1.3.258
	export LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LIBRARY_PATH
	export LD_LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LD_LIBRARY_PATH
	cd w90unk
	cp ../w90prep/WAVECAR .
	cp ../w90prep/CHGCAR .
	mpirun $vasp_w90 > $outfile 
	cd ..
fi

### Regular band structure calculation
if [ $bands -eq 1 ]; then
	echo 'Running band structure'
	cd elec_bands
	cp ../w90prep/CHGCAR .
	mpirun -n $SLURM_NTASKS $vasp > $outfile
	cd ..
fi


### Generate Wannier input files
if [ $w90gen -eq 1 ]; then
	source /opt/intel/composer_xe_2016/compilers_and_libraries_2016.4.258/linux/bin/compilervars.sh intel64
	module load mpi/intel-mpi-5.1.3.258
	export LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LIBRARY_PATH
	export LD_LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LD_LIBRARY_PATH
	echo 'Running VASP2Wannier90 cycle from WAVECAR'
	cd w90gen
	cp ../w90prep/WAVECAR .
	cp ../w90prep/CHGCAR .
	mv ../w90unk/UNK* .
	cp eig-gen-"$seedname".win "$seedname".win
	mpirun $vasp_w90 > $outfile 
	
	if [ $spinpol -eq 1 ];then
		echo 'Spin-polarized version'
		cp "$seedname".up.eig "$seedname".eig
		cp "$seedname".up.mmn "$seedname".mmn
	fi
	cp amn-gen-"$seedname".win "$seedname".win
	mpirun $vasp_w90 > $outfile 
	cd ..
if [ $calcdn -eq 1 ]; then
	mkdir w90dngen
	cd w90dngen
	
	cp ../w90prep/WAVECAR .
	cp ../w90prep/CHGCAR .
	mv ../w90unk/UNK* .
	cp ../w90gen/eig-gen-"$seedname".win .
	cp ../w90gen/amn-gen-"$seedname".win .
	cp eig-gen-"$seedname".win "$seedname".win
	mpirun $vasp_w90 > $outfile 
	echo 'Calculating down spin channel'
	cp "$seedname".dn.eig "$seedname".eig
	cp "$seedname".dn.mmn "$seedname".mmn
	cp amn-gen-"$seedname".win "$seedname".win
	mpirun $vasp_w90 > $outfile 
	cd ..
fi

fi

### Wannierization
if [ $w90run -eq 1 ]; then
	source /opt/intel/composer_xe_2016/compilers_and_libraries_2016.4.258/linux/bin/compilervars.sh intel64
	module load mpi/intel-mpi-5.1.3.258
	export LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LIBRARY_PATH
	export LD_LIBRARY_PATH=/opt/intel/composer_xe_2016/compilers_and_libraries_2016.3.223/linux/mpi/intel64/lib:$LD_LIBRARY_PATH
	echo 'Running Wannier90'
	cd w90run

	if [ $spinpol -eq 1 ];then
		echo 'Spin-polarized version'
		seedname=wannier90.up
	fi

        cp ../w90gen/"$seedname".eig .
        cp ../w90gen/"$seedname".amn .
        cp ../w90gen/"$seedname".mmn .
	mv ../w90unk/UNK* .
	mpirun "$w90" "$seedname" > "$seedname".out

	if [ $calcdn -eq 1 ];then
		echo 'Calculating down spin channel'
		seedname=wannier90.dn
        	cp ../w90gen/"$seedname".eig .
        	cp ../w90gen/"$seedname".amn .
        	cp ../w90gen/"$seedname".mmn .
		mpirun "$w90" "$seedname" > "$seedname".out
	fi
	cd ..
fi

