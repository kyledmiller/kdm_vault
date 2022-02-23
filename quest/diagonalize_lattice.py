#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

import numpy as np
from pymatgen.core.structure import Structure, Lattice
import sys
import os

def main():
    SYMPREC = 1e-6
    ANGLE_TOL = 0.01
    file_names = sys.argv[1:]
    if not os.path.isdir('diag'):
        os.mkdir('diag')
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        diag_lattice = Lattice(np.diag(struc.lattice.abc))
        diag_struc = struc.copy()
        diag_struc.lattice = diag_lattice
        print(diag_lattice)
        struc = diag_struc

        if file_name[-4:] == '.cif':
            struc.to(fmt='poscar', filename=(f'diag/{file_name[:-4]}.vasp'))
        elif file_name[-5:] == '.vasp':
            struc.to(fmt='poscar', filename=(f'diag/{file_name}'))
        else:
            struc.to(fmt='poscar', filename=(f'diag/{file_name}.vasp'))

if __name__ == "__main__":
    main()
