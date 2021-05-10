#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
Usage: python convert_poscar_cif.py POSCAR-1 POSCAR-2 POSCAR-3
"""


from pymatgen.core.structure import Structure
import sys

def main():
    SYMPREC = 1e-4
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        if file_name[-5:] == '.vasp':
            struc.to(fmt='cif', filename=(file_name[:-5]+'.cif'), symprec=SYMPREC, angle_tolerance=ANGLE_TOL)
        else:
            struc.to(fmt='cif', filename=(file_name+'.cif'), symprec=SYMPREC, angle_tolerance=ANGLE_TOL)
            
if __name__ == "__main__":
    main()
