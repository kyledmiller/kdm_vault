#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""
from pymatgen.core.lattice import Lattice
from pymatgen.core.structure import Structure
import numpy as np
import sys

def main():
    """ Takes in a tetragonal POSCAR (special c-axis) and modulates its c/a ratio """ 
    file_name = sys.argv[1]
   
    # Modulate axial ratios
    axial_ratio_modifiers = np.arange(0.8, 1.20001, 0.05)
    
    for m in axial_ratio_modifiers:
        
        # Parse structure
        struc = Structure.from_file(file_name)
        
        # Modify lattice constants
        lat_mod = m**(2/3) # to maintain constant volume
        lattice = struc.lattice.as_dict()
        lattice['matrix'][0][0] = lattice['matrix'][0][0]/np.sqrt(lat_mod)
        lattice['matrix'][1][1] = lattice['matrix'][1][1]/np.sqrt(lat_mod)
        lattice['matrix'][2][2] = lattice['matrix'][2][2]*lat_mod
        new_lat = Lattice.from_dict(lattice)
        struc.lattice = new_lat
        
        # Create modified POSCAR
        struc.to(fmt='poscar', filename=(file_name + f'-{np.round(m,2)}.vasp'))
            
if __name__ == "__main__":
    main()
