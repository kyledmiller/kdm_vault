loc='qaddr:/projects/b1027/KDMiller_work/BaCoS2/correct_mag/phonons'

#for iter in U0 U2 U4;do
for iter in 'prim-tet-U2';do
	mkdir $iter
	cd $iter
	scp $loc/$iter/FORCE_SETS .
	scp $loc/$iter/band.yaml .
	scp $loc/$iter/POSCAR .
	scp $loc/$iter/phonopy_disp.yaml .
	scp $loc/$iter/BORN .
	scp $loc/$iter/SPOSCAR .
	cd ..	
done