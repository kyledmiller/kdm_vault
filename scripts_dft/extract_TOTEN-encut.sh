#!/bin/bash
writefile=energies.txt
for i in $(seq 600 100 1200);

do
        printf $i 			>> $writefile
        grep TOTEN $i/OUTCAR | tail -1 	>> $writefile
done

