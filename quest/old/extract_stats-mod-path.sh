#!/bin/bash

writeDir=output_files
writeFile=stats.tsv

echo "ISPIN =" 
read ISPIN

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
if [ $ISPIN -eq 2 ];then
	printf "kpoint\tdisp\ttotal_energy\tdrift_x\tdrift_y\tdrift_z\tvolume\tmag_s\tmag_p\tmag_d\tmag_tot\n" >> $writeFile
else
	printf "kpoint\tdisp\ttotal_energy\tdrift_x\tdrift_y\tdrift_z\tvolume\n" >> $writeFile
fi

for kpt in 'G1' 'R1' 'X1' 'Z1' 'X2+X1';do
for disp in 0 5 10 15 20 25 30;do
	suffix=$kpt-disp$disp
	kpoint=${kpt:0:1}
        outfile="$suffix"/OUTCAR
	printf "$kpoint\t$disp" >> $writeFile
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
done
cp $writeFile $writeDir
