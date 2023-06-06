#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

import numpy as np
from pymatgen.core.structure import Structure, Lattice
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
import sys

def main():
    SYMPREC = 1e-3
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        #struc = struc.get_primitive_structure(tolerance=SYMPREC)
        sga = SpacegroupAnalyzer(struc)
        prim = sga.get_primitive_standard_structure()

        #diag_lattice = Lattice(np.diag(struc.lattice.abc))
        #diag_struc = struc.copy()
        #diag_struc.lattice = diag_lattice
        #print(diag_lattice)
        #struc = diag_struc

        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        if file_name[-5:] == '.vasp':
            struc.to(fmt='poscar', filename=(file_name[:-5] + f'-prim.vasp'))
        else:
            struc.to(fmt='poscar', filename=(file_name + '-prim.vasp'))
if __name__ == "__main__":
    main()
