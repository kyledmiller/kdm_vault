#!/bin/bash
out=stats.tsv

echo -e "\tP4nmm\tPba2\tP2c" >> $out

for x in 2 4 8 8z 9;do
	echo -ne x"$x""\t" >> $out
	for sym in P4nmm Pba2 P2c;do
		tail -1 struc_"$sym"'/x'"$x"'/bestcorr.out' | awk '{printf substr($2,0,7)"\t"}'	>> $out
	done
	echo "" >> $out
done
