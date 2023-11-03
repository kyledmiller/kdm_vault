#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
from pymatgen.io.cif import CifWriter
from convert_struc_sorted_poscar import sort_sites
import sys
import os

def main():
    SYMPREC = 1e-4
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        cw = CifWriter(struc, symprec=SYMPREC)
        #sga = SpacegroupAnalyzer(struc)
        #prim = sga.get_symmetrized_structure()
        #prim = struc.get_primitive_structure(tolerance=SYMPREC)
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        out_file_name = file_name.replace('.vasp','').replace('.cif','') + '_sym.cif'
        ### Make sure not to delete existing file
        existing = False
        if os.path.exists(out_file_name):
            existing = True
        cw.write_file(out_file_name)
        struc = Structure.from_file(out_file_name)
        struc = sort_sites(struc)
        struc.to(out_file_name.replace('.cif','.vasp'), fmt='poscar')
        if not existing:
            os.remove(out_file_name)
            
if __name__ == "__main__":
    main()
