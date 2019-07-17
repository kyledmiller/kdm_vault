name='Mg Ta2 O6'
dim='1 2 2'
tol='5e-3'
conf='template-irreps.conf'

cp ~/files_dft/$conf .
cp ~/scripts_dft/helper-extract_irreps-negative.py .
for kpt in 'G0 0 0' 'R0 0.5 0.5' 'X0 0.5 0' 'Z0 0 0.5';do
	label=${kpt:0:1}
	coord=${kpt:1}
	newConf=kpt$label-$conf
	cp $conf $newConf
	sed -i -e "s/name-flag/$name/" -e "s/dim-flag/$dim/" -e "s/irrep-flag/$coord $tol/"	$newConf
	phonopy $newConf
	python helper-extract_irreps-negative.py $label >> neg-irreps.txt
done
