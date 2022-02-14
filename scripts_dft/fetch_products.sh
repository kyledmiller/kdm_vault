#!/bin/bash

xwork=xaddr:/work/06098/tg853979/stampede2
qwork=qaddr:/projects/b1027/KDMiller_work
qworkp=qaddr:/projects/p30883

scp "$qworkp"/anion-sub_BaCoS2/nonmag-wannier-test/products.tar.gz .

tar xvfz products.tar.gz
rsync -av products/* .
\rm -r products
\rm products.tar.gz
