#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
import sys
import os
import numpy as np
from workflow_utils import sort_sites


def main():
    SYMPREC = 1e-6
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    os.makedirs('sorted', exist_ok=True)
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        struc = sort_sites(struc)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        out_file_name = 'sorted/' + file_name.replace('.vasp','').replace('.cif','') + '.vasp'
        struc.to(fmt='poscar', filename=out_file_name)
            
if __name__ == "__main__":
    main()
