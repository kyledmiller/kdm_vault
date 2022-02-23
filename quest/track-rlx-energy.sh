#!/bin/bash

for file in ./is2.ib"$1".*/std*; do
        tac $file | grep -m1 E0
done
