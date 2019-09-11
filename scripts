dim='1 2 2'

for kpt in 'G0 0 0' 'R0 0.5 0.5' 'X0 0.5 0' 'Z0 0 0.5';do
	label=${kpt:0:1}
	coord=${kpt:1}
	newConf=anime-$label.conf
	touch $newConf
	echo "DIM = $dim"			>> $newConf
	echo "ANIME_TYPE = V_SIM"	>> $newConf
	echo "ANIME = $coord"		>> $newConf
	phonopy $newConf
	mv anime.ascii anime-$label.ascii
	rm anime-$label.conf
done
