#!/bin/bash

writeFile=stats.tsv

#echo "ISPIN ="
#read ISPIN
ISPIN=1
prefix="/static"
stdname="std.out"

if [ $ISPIN -eq 2 ];then
        printf "run_id\tenergy\tvolume\tmag_s\tmag_p\tmag_d\tmag_tot\tpoint_group\tlattice\n" >> $writeFile
else
        printf "run_id\tenergy\tvolume\tpoint_group\tlattice\n" >> $writeFile
fi

while [ "$1" != "" ]; do
        outfile="$1""$prefix/OUTCAR"
        printf "$1" >> $writeFile
        echo $outfile


        ### Extract info otherwise (converged prior to reaching NELMth step)
        grep TOTEN $outfile | tail -1 | awk '{printf "\t"$5; exit}' >> $writeFile
        if [ $ISPIN -eq 2 ];then
                tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$2; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$3; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$4; exit}' >> $writeFile
                tac $outfile | awk '/tot     / {printf "\t"$5; exit}' >> $writeFile
                tac $outfile | awk '/static configuration/ {printf "\t"$8; exit}' >> $writeFile
                tac $outfile | awk '/LATTYP/ {printf "\t"$5; exit}' >> $writeFile
        else
                tac $outfile | awk '/volume/ {printf "\t"$5; exit}' >> $writeFile
                tac $outfile | awk '/static configuration/ {printf "\t"$8; exit}' >> $writeFile
                tac $outfile | awk '/LATTYP/ {printf "\t"$5; exit}' >> $writeFile
        fi

        ### Checking electronic convergence
        nelm="$(cat $outfile | awk '/NELM   =/ {printf $3; exit}')"
        nelm="${nelm%?}"
        echo $nelm
        stdout="$1""$prefix/$stdname"

        ### Report nonconvergence if NELMth step occurs or calculation isn't finished
        if grep -q "$nelm    -" $stdout || ! grep -q " 1 F= " $stdout; then
                echo " /\\ File above is NOT converged!"
                echo "<-UNCONVERGED" >> $writeFile
        else
                echo "" >> $writeFile
        fi
        shift
done
