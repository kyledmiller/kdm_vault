from ase import io
import numpy as np

atoms = io.read('POSCAR.vasp',format='vasp')
positions = atoms.get_positions()
print(positions)
randoms = 0.05*np.random.rand(len(atoms),3)
print(randoms)
new_pos = randoms + positions
print(new_pos)
atoms.set_positions(new_pos)

io.write('POSCAR-distorted.vasp', atoms, format='vasp', direct=True)