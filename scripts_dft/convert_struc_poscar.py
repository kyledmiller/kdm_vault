#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
import sys
import os

def main():
    SYMPREC = 1
    ANGLE_TOL = 5
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        out_file_name = file_name.replace('.vasp','').replace('.cif','') + '.vasp'
        if os.path.exists(out_file_name): print('Renaming file to avoid overwrite'); out_file_name = 'transf_'+out_file_name
        struc.to(fmt='poscar', filename=out_file_name)
            
if __name__ == "__main__":
    main()
