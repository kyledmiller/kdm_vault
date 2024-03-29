#!/bin/bash

while [ "$1" != "" ]; do

        # Removing unwanted / from tab completion
        last="${1: -1}"
        if [ $last == "/" ]; then
                label=${1%?}
        else
                label=$1
        fi
        echo $label

	### Phonon processing ###
	# Copy in necessary config files
	conf=anime.conf
	cp $conf $label
	cd $label
	
	# Executes in each system's directory
	#phonopy -f {1..9}/vasprun.xml
	phonopy $conf

	cd ..	

        shift
done
