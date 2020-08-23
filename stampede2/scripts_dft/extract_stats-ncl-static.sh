#!/bin/bash

writeFile=stats.tsv

echo "ISPIN ="
read ISPIN


if [ $ISPIN -eq 2 ];then
        printf "run_id\tenergy\tvolume\tmag_x\tmag_y\tmag_z\n" >> $writeFile
else
        printf "run_id\tenergy\tvolume\n" >> $writeFile
fi

while [ "$1" != "" ]; do
        outfile="$1/static/OUTCAR"
        printf "$1" >> $writeFile
        echo $outfile


	### Extract info
        grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile
	if [ $ISPIN -eq 2 ];then
	        tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
	        tac $outfile | awk -v n=3 '/tot     /{l++} (l==n){printf "\t"$5; exit}' >> $writeFile
	        tac $outfile | awk -v n=2 '/tot     /{l++} (l==n){printf "\t"$5; exit}' >> $writeFile
	        tac $outfile | awk -v n=1 '/tot     /{l++} (l==n){printf "\t"$5; exit}' >> $writeFile
	        #cat $outfile | awk '/tot     / {printf "\t"$5; exit}' >> $writeFile
	        tac $outfile | awk '/tot     / {printf "\t"$5; exit}' >> $writeFile
	else
	        tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
	fi
	
	### Checking electronic convergence
	nelm="$(cat $outfile | awk '/NELM   =/ {printf $3; exit}')"
	nelm="${nelm%?}"
	#echo $nelm
	stdout="$1/static/std.out"

	### Report nonconvergence if NELMth step occurs or calculation isn't finished
	if grep -q "$nelm    -" $stdout || ! grep -q " 1 F= " $stdout; then
		echo " /\\ File above is NOT converged!"
		echo "<-UNCONVERGED" >> $writeFile
	else
		echo "" >> $writeFile
	fi
        shift
done
