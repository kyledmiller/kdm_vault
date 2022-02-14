from pymatgen.io.vasp.outputs import Outcar
from pymatgen.core.structure import Structure
from pymatgen.io.cif import CifWriter

suffices = ['modI1_U4', 'altmag_modI1_U4']
mag_indices = range(8,17)

for suffix in suffices:
    struc = Structure.from_file(f'POSCAR-{suffix}.vasp')
    outcar = Outcar(f'OUTCAR-{suffix}')
    magmoms = [round(mag['tot']*10)/10 for mag in outcar.magnetization]
    print(magmoms)
    struc.add_site_property('magmom',magmoms)
    struc.to('cif',f'magCIF-{suffix}.cif', write_magmoms=True)
