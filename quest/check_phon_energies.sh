#!/bin/bash

type="phon" # Options: static, relax, estruc, w90, phon

while [ "$1" != "" ]; do

        # Removing unwanted / from tab completion
        last="${1: -1}"
        if [ $last == "/" ]; then
                label=${1%?}
        else
                label=$1
        fi
        echo $label

        # Extracting files
        if [ $type == "relax" ]; then
		echo 'not yet implemented'
        elif [ $type == phon ]; then
		cd $1; grep E0 */std*; cd ..
        else
                echo Invalid type: $type
        fi
        shift
