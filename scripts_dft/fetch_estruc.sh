#!/bin/bash

loc='qaddr:/projects/b1027/KDMiller_work/trirutiles/MgTa2O6/carrier_doping/static-AFM'

#for iter in '1-d0' '1-d05' '1-d1' '3-d0' '3-d05' '3-d1';do
for iter in 'd065' 'd075' 'd1';do
#for iter in 0 10 20 30 40;do
#for iter in 0 10 20 30 40 50 60;do
	scp $loc/$iter/output_files/vasprun-dos.xml vasprun-dos-$iter.xml	
	scp $loc/$iter/output_files/vasprun-bands.xml vasprun-bands-$iter.xml
done
