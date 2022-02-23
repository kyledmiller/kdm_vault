#!/bin/bash

outputDir='output_files'
writeFile="$outputDir"'/stats.txt'
mkdir $outputDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\n" >> $writeFile
mkdir $outputDir
for suffix in 'd0' 'd025' 'd05' 'd075' 'd1';do    
        outfile="$suffix"/final-OUTCAR
	printf "$suffix" >> $writeFile
	echo $suffix
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5}' >> $writeFile
	tac $outfile | awk '/pressure/ {printf "\t"$4}' >> $writeFile	
	tac $outfile | awk '/pressure/ {printf "\t"$9}' >> $writeFile
	tac $outfile | awk '/drift/ {printf "\t"$3}' >> $writeFile 
	tac $outfile | awk '/drift/ {printf "\t"$4}' >> $writeFile 
	tac $outfile | awk '/drift/ {printf "\t"$5"\n"}' >> $writeFile 
done
