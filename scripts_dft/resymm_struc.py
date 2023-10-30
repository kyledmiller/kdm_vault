#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure, Lattice
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
import sys

def main():
    SYMPREC = 1e-2
    ANGLE_TOL = 1.0
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        sga = SpacegroupAnalyzer(struc, symprec=SYMPREC, angle_tolerance=ANGLE_TOL)
        struc = sga.get_symmetrized_structure()
        
        if file_name.split('.')[-1] == 'vasp' or file_name.split('/')[-1][-3:] == 'CAR':
            out_file_name = file_name.replace('.vasp','') + '_resym.vasp'
            struc.to(fmt='poscar', filename=out_file_name)
        else:
            out_file_name = file_name.replace('.cif','') + '_resym.cif'
            struc.to(fmt='cif', filename=out_file_name)

        print(f'Generated {out_file_name},  SG = ' + str(sga.get_space_group_number()))

if __name__ == "__main__":
    main()
