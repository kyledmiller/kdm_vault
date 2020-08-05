from ase.spacegroup.symmetrize import check_symmetry
from ase import Atoms
import ase.io.vasp as vaspio
import sys

### Import structure
fname = sys.argv[1]
# fname = 'POSCAR-exp-P2c.vasp'
exp_struc = vaspio.read_vasp(fname)

check_symmetry(exp_struc, verbose=True)