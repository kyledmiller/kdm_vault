#!/bin/bash

xwork=xaddr:/work/06098/tg853979/stampede2
qwork=qaddr:/projects/b1027/KDMiller_work

scp "$qwork"/BaCoS2_follow-up/wannier/products.tar.gz .

tar xvfz products.tar.gz
\mv products/* .
rmdir products
\rm products.tar.gz
