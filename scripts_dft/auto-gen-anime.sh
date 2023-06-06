dim='4 4 1'

for kpt in 'I0.175 0.175 0';do
	label=${kpt:0:1}
	coord=${kpt:1}
	newConf=anime-$label.conf
	touch $newConf
	echo "DIM = $dim"		>> $newConf
	echo "ANIME_TYPE = V_SIM"	>> $newConf
	echo "ANIME = $coord"		>> $newConf
    echo "FC_SYMMETRY = .TRUE." >> $newConf
	phonopy $newConf
	mv anime.ascii anime-$label.ascii
	rm anime-$label.conf
done
