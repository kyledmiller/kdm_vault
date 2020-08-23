#!/bin/bash

writeDir=output_files
writeFile=stats.txt

echo "ISPIN =" 
read ISPIN

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
if [ $ISPIN -eq 2 ];then
	printf "Total Energy\tDrift in x\tDrift in y\tDrift in z\tVolume\tMag s\t Mag p \t Mag d\t Mag tot\n" >> $writeFile
else
	printf "Total Energy\tDrift in x\tDrift in y\tDrift in z\tVolume\n" >> $writeFile
fi


outfile=OUTCAR
grep TOTEN $outfile | tail -1 | awk '{printf $5; exit}' >> $writeFile
tac $outfile | awk '/drift/ {printf "\t"$3; exit}' >> $writeFile 
tac $outfile | awk '/drift/ {printf "\t"$4; exit}' >> $writeFile 
tac $outfile | awk '/drift/ {printf "\t"$5; exit}' >> $writeFile

if [ $ISPIN -eq 2 ];then
        tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
        tac $outfile | awk '/tot     / {printf "\t"$2; exit}' >> $writeFile
        tac $outfile | awk '/tot     / {printf "\t"$3; exit}' >> $writeFile
        tac $outfile | awk '/tot     / {printf "\t"$4; exit}' >> $writeFile
        tac $outfile | awk '/tot     / {printf "\t"$5"\n"; exit}' >> $writeFile
	
else
	tac $outfile | awk '/volume/ {printf "\t"$5"\n"; exit}' >> $writeFile
fi
	
cp $writeFile $writeDir
