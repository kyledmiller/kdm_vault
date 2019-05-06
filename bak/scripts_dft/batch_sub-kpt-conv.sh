#!/bin/bash
encut=700
var=kpt 

#for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
for i in '4 3 2' '4 4 2' '5 4 2' '5 5 2' '5 5 3' '6 5 3' '6 6 3';
do
        name="$(echo -e "$i" | tr -d '[:space:]')"
        cd "$var$name"
        sbatch sub-static.sh
	cd ..
done

