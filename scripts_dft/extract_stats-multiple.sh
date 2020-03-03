#!/bin/bash

writeDir=output_files
writeFile=stats.tsv

echo "ISPIN =" 
read ISPIN

mkdir $writeDir

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);
if [ $ISPIN -eq 2 ];then
	printf "run_id\tenergy\tpres\tpulay\tdrift_x\tdrift_y\tdrift_z\tvolume\tmag_s\tmag_p\tmag_d\tmag_tot\n" >> $writeFile
else
	printf "run_id\tenergy\tpres\tpulay\tdrift_x\tdrift_y\tdrift_z\tvolume\n" >> $writeFile
fi

#for suffix in 'd0' 'd025' 'd05' 'd055' 'd06' 'd065' 'd07' 'd075' 'd08' 'd085' 'd09' 'd095' 'd1';do    
#for suffix in 'unmod' 'G1' 'R1' 'X1' 'Z1';do
for suffix in 'G1' 'R1' 'X1' 'Z1';do

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
