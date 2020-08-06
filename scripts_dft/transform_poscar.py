#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
import sys

def main():
    SYMPREC = 1e-6
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        
        struc.make_supercell([[1,1,0],[-1,1,0],[0,0,1]])

        if file_name[-5:] == '.vasp':
            struc.to(fmt='poscar', filename=(file_name[:-5] + '.vasp'))
        elif file_name[-4:] == '.cif':
            struc.to(fmt='poscar', filename=(file_name[:-4] + '.vasp'))
        else:
            struc.to(fmt='poscar', filename=(file_name + '.vasp'))

if __name__ == "__main__":
    main()
