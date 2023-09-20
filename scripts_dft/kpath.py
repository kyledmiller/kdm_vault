# Requires: pymatgen module
# Generates KPOINTS.bands file with high symmetry lines added for
# an arbitrary POSCAR with symmetry precision=1e-3

from pymatgen.symmetry.bandstructure import HighSymmKpath
from pymatgen.io.vasp.inputs import Kpoints
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
from pymatgen.symmetry.kpath import *
import sys


def kpath_phonopy(struc, func='KPathSetyawanCurtarolo')
    # Available kpt functions: KPathSetyawanCurtarolo 'KPathLatimerMunro' 'KPathSeek'
    kp = func(struc)
    ### Phonopy formatted strings
    symbol_str = ' , '.join([' '.join([f'${elem}$' for elem in path]) for path in kp.kpath['path']])
    coords_str = ' , '.join([' '.join([f'{" ".join([str(coord) for coord in kp.kpath["kpoints"][elem]])}' for elem in path]) for path in kp.kpath['path']])
    return coords_str, symbol_str


def kpath_vasp(struc, primitive=False, func='KPathSetyawanCurtarolo'):
    if primitive: 
        sga = SpacegroupAnalyzer(struc, symprec=1e-5, angle_tolerance=0.1)
        print(f'Found spacegroup {sga.get_space_group_symbol()}')
        struc = sga.get_primitive_standard_structure(international_monoclinic=False)
    kpath = HighSymmKpath(struc, symprec=1e-5, angle_tolerance=0.1)
    kpoints = Kpoints.automatic_linemode(20, kpath)
    #kpoints.write_file("KPOINTS.bands")
    return kpoints
    
