#!/bin/bash
var=kpt
writefile=energies.txt

printf "ENCUT\tTotal Energy\tCPU time\n"            	>> $writefile

for outfile in $(find . -wholename '*/OUTCAR' |sort); 
do     
	echo ${outfile:2}
        echo -n -e "${outfile:6:8}\t"				>> $writefile
        tac $outfile | awk '/TOTEN/{printf $5"\t"; exit}' 	>> $writefile
        awk '/CPU time/{printf $6"\n"}' $outfile       >> $writefile
	
done
