#!/bin/bash

writeFile=stats.txt

echo "ISPIN =" 
read ISPIN

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
if [ $ISPIN -eq 2 ];then
	printf "Run ID\tTotal Energy\tDrift in x\tDrift in y\tDrift in z\tVolume\tMag s\t Mag p \t Mag d\t Mag tot\n" >> $writeFile
else
	printf "Run ID\tTotal Energy\tDrift in x\tDrift in y\tDrift in z\tVolume\n" >> $writeFile
fi

for suffix in 'F-F' 'F-A' 'A-F' 'A-A';do    

        outfile="$suffix"/OUTCAR
	printf "$suffix" >> $writeFile
	echo $suffix
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile
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
