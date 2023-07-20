#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
import sys

def main():
    SYMPREC = 1e-4
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        sga = SpacegroupAnalyzer(struc)
        prim = sga.get_primitive_standard_structure()
        #prim = struc.get_primitive_structure(tolerance=SYMPREC)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        if file_name[-5:] == '.vasp':
            prim.to(fmt='cif', filename=(file_name[:-5]+'_prim.cif'))
        elif file_name[-4:] == '.cif':
            prim.to(fmt='cif', filename=(file_name[:-4]+'_prim.cif'))
        else:
            prim.to(fmt='cif', filename=(file_name+'_prim.cif'))
            
if __name__ == "__main__":
    main()
