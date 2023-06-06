# Requires: pymatgen module
# Generates KPOINTS.bands file with high symmetry lines added for
# an arbitrary POSCAR with symmetry precision=1e-3

import pymatgen as pmg
from pymatgen.symmetry.bandstructure import HighSymmKpath
from pymatgen.io.vasp.inputs import Kpoints
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
import sys

struc_name = sys.argv[1]

struct = pmg.core.Structure.from_file(struc_name)
sga = SpacegroupAnalyzer(struct, symprec=1e-5, angle_tolerance=0.1)
print(f'Found spacegroup {sga.get_space_group_symbol()}')
struct = sga.get_primitive_standard_structure(international_monoclinic=False)
kpath = HighSymmKpath(struct, symprec=1e-5, angle_tolerance=0.1)
kpoints = Kpoints.automatic_linemode(16, kpath)
kpoints.write_file("KPOINTS.bands")
