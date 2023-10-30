#!/bin/bash
echo $@
for var in $@; do
    outname="$var"_findsym.cif
    sudo docker run -i --rm kramergroup/findsym < $var > $outname 
    sed -i '/# /,$!d' $outname
done
