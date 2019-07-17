#!/bin/bash

writeDir=output_files
writeFile=stats.txt

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\n" >> $writeFile
for suffix in 'd0' 'd025' 'd05' 'd0625' 'd075' 'd1';do    
#for suffix in 'G1' 'G2' 'G3' 'R1' 'R2' 'X1' 'X2' 'X3' 'Z1' 'Z2';do

        outfile="$suffix"/final-OUTCAR
	printf "$suffix" >> $writeFile
	echo $suffix
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile
	tac $outfile | awk '/pressure/ {printf "\t"$4; exit}' >> $writeFile	
	tac $outfile | awk '/pressure/ {printf "\t"$9; exit}' >> $writeFile
	tac $outfile | awk '/drift/ {printf "\t"$3; exit}' >> $writeFile 
	tac $outfile | awk '/drift/ {printf "\t"$4; exit}' >> $writeFile 
	tac $outfile | awk '/drift/ {printf "\t"$5"\n"; exit}' >> $writeFile 
done
cp $writeFile $writeDir
