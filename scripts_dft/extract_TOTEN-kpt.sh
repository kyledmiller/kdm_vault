#!/bin/bash
var=kpt
writefile=energies.txt
for outfile in $(find . -wholename '*/OUTCAR' |sort); 
do    
        printf "${outfile:5:3}" 				>> $writefile
	echo ${outfile:2}
	grep TOTEN $outfile | tail -1 | awk '{print "\t"$5}' 	>> $writefile
done
