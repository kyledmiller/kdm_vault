#!/bin/bash
var=kpt 

#for i in '2 3 3' '2 4 4' '3 5 5' '4 5 5' '4 6 6' '5 6 6' '5 7 7' '5 8 8';
#for i in '4 3 2' '4 4 2' '5 4 2' '5 5 2' '5 5 3' '6 5 3' '6 6 3';
#for i in '6 6 3' '7 7 3' '7 7 4' '8 8 4' '9 9 4' '9 9 5' '10 10 5';
for i in '7 2 5' '8 3 5' ' 8 3 6' '9 3 7' '11 4 7' '11 4 8';

do
        name="$(echo -e " $i" | tr -s '[:space:]' '-')"
        name=${name%?} #remove trailing dash
        cd "$var$name"
	pwd | cat
        sbatch sub-static.sh
	cd ..
done

