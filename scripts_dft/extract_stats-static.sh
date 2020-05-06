#!/bin/bash

writeFile=stats.tsv

echo "ISPIN =" 
read ISPIN


if [ $ISPIN -eq 2 ];then
        printf "run_id\tenergy\tvolume\tmag_s\tmag_p\tmag_d\tmag_tot\tpoint_group\tlattice\n" >> $writeFile
else
        printf "run_id\tenergy\tvolume\tpoint_group\tlattice\n" >> $writeFile
fi

while [ "$1" != "" ]; do
	outfile="$1/static/OUTCAR"
	printf "$1" >> $writeFile
	echo $outfile
	grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile

        if [ $ISPIN -eq 2 ];then
                tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$2; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$3; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$4; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$5; exit}' >> $writeFile
 		tac $outfile | awk '/static configuration/ {printf "\t"$8; exit}' >> $writeFile
 		tac $outfile | awk '/LATTYP/ {printf "\t"$5"\n"; exit}' >> $writeFile
	else
        	tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
 		tac $outfile | awk '/static configuration/ {printf "\t"$8; exit}' >> $writeFile
 		tac $outfile | awk '/LATTYP/ {printf "\t"$5"\n"; exit}' >> $writeFile
	fi
	shift
done
