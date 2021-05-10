#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
import sys

def main():
    SYMPREC = 1e-3
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        prim = struc.get_primitive_structure(tolerance=SYMPREC)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        if file_name[-5:] == '.vasp':
            prim.to(fmt='poscar', filename=(file_name[:-5] + f'-prim.vasp'))
        else:
            prim.to(fmt='poscar', filename=(file_name + '-prim.vasp'))
if __name__ == "__main__":
    main()
