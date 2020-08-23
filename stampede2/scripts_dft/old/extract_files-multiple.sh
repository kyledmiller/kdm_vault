#!/bin/bash

writeDir=output_files
writeFile=stats.txt

#echo "ISPIN =" 
#read ISPIN

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
#if [ $ISPIN -eq 2 ];then
#	printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\tVolume\tMag s\t Mag p \t Mag d\t Mag tot\n" >> $writeFile
#else
#	printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\tVolume\n" >> $writeFile
#fi

#for suffix in 'd0' 'd025' 'd05' 'd055' 'd06' 'd065' 'd07' 'd075' 'd08' 'd085' 'd09' 'd095' 'd1';do    
for suffix in 'unmod' 'G1' 'R1' 'X1' 'Z1';do
	cd $suffix
	cp final-OUTCAR ../$writeDir/OUTCAR-$suffix
	cp final-POSCAR ../$writeDir/POSCAR-$suffix.vasp
	cp final-std.out ../$writeDir/std.out-$suffix
	cd ..
done
