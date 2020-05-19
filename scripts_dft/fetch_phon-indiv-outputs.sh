loc='qaddr:/projects/b1027/KDMiller_work/BaCoS2/correct_mag/Pba2-phonons'

for iter in 'U2';do
	mkdir $iter
	cd $iter

	mkdir outputs
	cd outputs
	
	rsync -avz --include='*/' --include="/*/EIGENVAL" --include="/*/OUTCAR" --exclude="*" $loc/$iter/ .	
	#rsync -avz --include="*/EIGENVAL" --include="*/OUTCAR" --exclude='*' $loc/$iter/1 .	

#	for j in {1..24};do
#		scp $loc/$iter/$j/EIGENVAL EIGENVAL-$j
#		scp $loc/$iter/$j/OUTCAR OUTCAR-$j		
#	done
	cd ..

	cd ..	
done
