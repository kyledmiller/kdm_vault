#!/bin/bash

writeFile='stats.txt'

#for outfile in $(find . -wholename '*/final-OUTCAR' |sort);

printf "Total Energy\tPres\tPulay\tDrift in x\tDrift in y\tDrift in z\n" >> $writeFile
outfile=final-OUTCAR
grep TOTEN $outfile | tail -1 | awk '{printf $5; exit}' >> $writeFile
tac $outfile | awk '/pressure/ {printf "\t"$4; exit}' >> $writeFile	
tac $outfile | awk '/pressure/ {printf "\t"$9; exit}' >> $writeFile
tac $outfile | awk '/drift/ {printf "\t"$3; exit}' >> $writeFile 
tac $outfile | awk '/drift/ {printf "\t"$4; exit}' >> $writeFile 
tac $outfile | awk '/drift/ {printf "\t"$5"\n"; exit}' >> $writeFile
