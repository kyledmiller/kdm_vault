#!/bin/bash

writeDir=output_files
writeFile=stats.txt

echo "ISPIN =" 
read ISPIN

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
if [ $ISPIN -eq 2 ];then
	printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\tVolume\tMag s\t Mag p \t Mag d\t Mag tot\n" >> $writeFile
else
	printf "Run ID\tTotal Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\tVolume\n" >> $writeFile
fi

for suffix in 'd0' 'd025' 'd05' 'd055' 'd06' 'd065' 'd07' 'd075' 'd08' 'd085' 'd09' 'd095' 'd1';do    
#for suffix in 'G1' 'G2' 'G3' 'R1' 'R2' 'X1' 'X2' 'X3' 'Z1' 'Z2';do

        outfile="$suffix"/final-OUTCAR
	printf "$suffix" >> $writeFile
	echo $suffix
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile
	tac $outfile | awk '/pressure/ {printf "\t"$4; exit}' >> $writeFile	
	tac $outfile | awk '/pressure/ {printf "\t"$9; exit}' >> $writeFile
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
	
done
cp $writeFile $writeDir
