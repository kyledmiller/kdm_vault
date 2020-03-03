#!/bin/bash
writefile=energies.txt

printf "ENCUT\tTotal Energy\tCPU time\n"            >> $writefile

for i in $(seq 400 100 900);
do
	file=$i/OUTCAR
        printf $i"\t"			            >> $writefile
        #grep TOTEN $i/OUTCAR | tail -1              >> $writefile
	tac $file | awk '/TOTEN/{printf $5"\t"; exit}' >> $writefile
	awk '/CPU time/{printf $6"\n"}' $i/OUTCAR        >> $writefile

done

