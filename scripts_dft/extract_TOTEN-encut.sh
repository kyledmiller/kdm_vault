#!/bin/bash

for i in $(seq 100 100 900);

do
        printf $i >>Energy.txt
        grep TOTEN $i/OUTCAR | tail -1 >>Energy.txt
done

