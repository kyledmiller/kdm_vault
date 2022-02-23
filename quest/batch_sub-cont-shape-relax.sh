#!/bin/bash

for iter in 'G1' 'R1' 'X1' 'Z1';do

echo "Current job: $iter -- Please provide job ID from it's parent."
read jobID

cd $iter
sbatch --dependency=afterany:$jobID sub-cont-shape-relax.sh $iter
cd ..

done

