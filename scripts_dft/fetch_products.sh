#!/bin/bash

stampede=xaddr:/work/06098/tg853979/stampede2

scp "$stampede"/BaCoS2_follow-up/relax/products.tar.gz .

tar xvfz products.tar.gz
\mv products/* .
rmdir products
\rm products.tar.gz
