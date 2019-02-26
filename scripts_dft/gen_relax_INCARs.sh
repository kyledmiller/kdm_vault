#!/bin/bash
fname=INCAR.relax
sed -e "s/ISIF\s=\s../ISIF\ =\ 7\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" INCAR > INCAR.is7.ib2
sed -e "s/ISIF\s=\s../ISIF\ =\ 7\ /" -e "s/IBRION\s=\s../IBRION\ =\ 1\ /" INCAR > INCAR.is7.ib1
sed -e "s/ISIF\s=\s../ISIF\ =\ 2\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" INCAR > INCAR.is2.ib2
sed -e "s/ISIF\s=\s../ISIF\ =\ 2\ /" -e "s/IBRION\s=\s../IBRION\ =\ 1\ /" INCAR > INCAR.is2.ib1
#sed -e "s/ISIF\s=\s../ISIF\ =\ 7\ /" -e "s/IBRION\s=\s../IBRION\ =\ 2\ /" INCAR > INCAR.static
