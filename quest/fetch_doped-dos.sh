#!/bin/bash

#for iter in '1-d0' '1-d05' '1-d1' '3-d0' '3-d05' '3-d1';do
for iter in 'd0' 'd025' 'd05' 'd075' 'd1' 'd0625';do
	scp qaddr:/projects/b1027/KDMiller_work/trirutiles/MgTa2O6/carrier_doping/elec_dos/$iter/vasprun.xml vasprun-$iter.xml
done
