#!/bin/bash

loc=/projects/b1027/KDMiller_work/BaXS2/hub-u-estruc/

for iter in '5a' 'og' 'dft';do
for u in 0 1 3 5;do
	tag=$iter-U$u
	scp qaddr:"$loc$tag"/static/OUTCAR OUTCAR-$tag
done
done
