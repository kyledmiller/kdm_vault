#!/bin/bash
var=kpt
for outfile in $(find . -wholename '*/OUTCAR' |sort); 
do    
        printf "${outfile:5:3}" >> Energy.txt
	echo ${outfile:2}
	grep TOTEN $outfile | tail -1 | awk '{print "\t"$5}' >> Energy.txt
done
