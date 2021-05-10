#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

from pymatgen.core.structure import Structure
from pymatgen.core.lattice import Lattice
import sys
import numpy as np

def main():
    SYMPREC = 1e-6
    ANGLE_TOL = 0.1
    file_names = sys.argv[1:]
    for file_name in file_names:
        struc = Structure.from_file(file_name)
        og_lattice = struc.lattice        
        print(f'{file_name},  SG = ' + str(struc.get_space_group_info(symprec=SYMPREC, angle_tolerance=ANGLE_TOL)))
        
        for strain in np.linspace(-0.02,0.02,3):
            strained_matrix = og_lattice.as_dict()['matrix']
            
            # Volume-preserving c-strain
            c2 = og_lattice.c*(1+strain)
            a2 = np.sqrt(  (og_lattice.c * (og_lattice.a)**2) / c2 )
            strained_matrix[0][0] = a2
            strained_matrix[1][1] = a2
            strained_matrix[2][2] = c2
            
            strained_lattice = Lattice(strained_matrix)
            strained_struc = struc.copy()
            strained_struc.lattice = strained_lattice

            if file_name[-5:] == '.vasp':
                strained_struc.to(fmt='poscar', filename=(file_name[:-5] + f'-cst-vol-c{np.round(strain*100,1)}.vasp'))
            else:
                strained_struc.to(fmt='poscar', filename=(file_name + f'-cst-vol-c{np.round(strain*100,1)}.vasp'))
    	
if __name__ == "__main__":
    main()
