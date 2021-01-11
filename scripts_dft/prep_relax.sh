#!/bin/bash

# Generate the required versions of the INCAR for each relaxation step
fname=INCAR.relax

for isif in 7 2; do
for ibrion in 2 1; do
        sed -e "s/ISIF.*/ISIF\ =\ $isif\ /" -e "s/IBRION.*/IBRION\ =\ $ibrion\ /" $fname > INCAR.is"$isif".ib"$ibrion"
        if [ $isif -eq 7 ];then
                sed -i "s/EDIFFG.*/EDIFFG = -0.1/" INCAR.is"$isif".ib"$ibrion"
        fi
done
done
