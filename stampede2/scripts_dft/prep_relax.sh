#!/bin/bash

# Generate the required versions of the INCAR for each relaxation step
fname=INCAR.relax

for isif in isif-flag; do
for ibrion in 2 1; do
	sed -e "s/ISIF\s=\s../ISIF\ =\ $isif\ /" -e "s/IBRION\s=\s../IBRION\ =\ $ibrion\ /" $fname > INCAR.is"$isif".ib"$ibrion"
	if [ $isif -eq 7 ];then
		sed -i "s/EDIFFG/#EDIFFG/" INCAR.is"$isif".ib"$ibrion"
	fi
done
done
