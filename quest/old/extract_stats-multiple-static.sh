#!/bin/bash

writeDir=output_files
writeFile=stats.tsv

echo "ISPIN =" 
read ISPIN

#mkdir $writeDir

if [ $ISPIN -eq 2 ];then
	printf "Run ID\tTotal Energy\tVolume\tMag s\t Mag p \t Mag d\t Mag tot\n" >> $writeFile
else
	printf "Run ID\tTotal Energy\tVolume\n" >> $writeFile
fi

for outfile in $(find . -wholename '*/static/OUTCAR' | sort);do
#for func in PS PBE;do
#for struc in og rlx 5a;do
#	suffix=$func-$struc
#        outfile="$suffix"/static/OUTCAR
	printf "$outfile" >> $writeFile
	echo $outfile
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile

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
