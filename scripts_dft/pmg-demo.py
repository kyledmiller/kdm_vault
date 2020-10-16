#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

### Structure ###
#################

from pymatgen.core.structure import Structure
from pymatgen.core.lattice import Lattice
import numpy as np


### Import structure
struc = Structure.from_file('POSCAR-experimental')

### Volume-preserving strain
for strain in [-0.02, 0, 0.02]:
    og_lattice = struc.lattice
    strained_matrix = og_lattice.as_dict['matrix']
    c2 = og_lattice.c*(1+strain)
    a2 = np.sqrt(  (og_lattice.c * (og_lattice.a)**2) / c2 )
    strained_matrix[0][0], strained_matrix[1][1] = a2, a2
    strained_matrix[2][2] = c2
    strained_lattice = Lattice(strained_matrix)
    strained_struc = struc.copy()
    strained_struc.lattice = strained_lattice
    strained_struc.to(fmt='poscar', filename=f'POSCAR-strain{strain}')
    

### VASP Output ###
###################

from pymatgen.io.vasp.outputs import Eigenval, Outcar

### Parsing output files
out = Outcar('OUTCAR')
eig = Eigenval('EIGENVAL')

### Extract energy
out.read_pattern({"energy": "energy\(sigma->0\)\s+=\s+([\d\-\.]+)"}, 
                 reverse=True, terminate_on_match=True)

### Extract band gap
band_gap = np.round(eig.eigenvalue_band_properties[0],3)

### Extract magnetic moments
co_mag_moms =  out.magnetization[8:16]

### Extract volume
volume = out.read_pattern({"volume": "volume of cell :\s+(\d+\.\d+)*"}, 
                 reverse=True, terminate_on_match=True)[0][0]


### Electronic Structure Plotting ###
#####################################

from pymatgen.io.vasp.outputs import Vasprun
from pymatgen.electronic_structure.plotter import DosPlotter
from pymatgen.electronic_structure.core import Orbital
from pymatgen.electronic_structure.dos import Dos
    
### Extract complete DOS from vasprun
vr = Vasprun('vasprun.xml')
cdos = vr.complete_dos
tdos = vr.tdos

### Plot site-orbital-projected DOS
dplt = DosPlotter(sigma=0.05)
pdoss = cdos.pdos
for site_idx in [2,3]:
    for orbital, name in zip([4,5,6,7,8], ['dxy', 'dyz', 'dz2', 'dxz', 'dx2']):
        site = cdos.structure[site_idx]
        elem = site.species.elements[0]
        efermi = cdos.efermi
        energies = cdos.energies
        orb_dos = pdoss[site][Orbital(orbital)]
        dplt.add_dos(f'{elem}-{name}',
                     Dos(efermi, energies, orb_dos))


### MP integration ###
######################

from pymatgen.ext.matproj import MPRester

### Establish search criteria
criteria = { '$and':[{'elements': {'$in': ['O', 'S']}}, 
                     {'elements': {'$in': [transition_metals]}}, 
                     {'elements': {'$nin': ['Ag']}}],
            'nelements': {'$eq': 2}}

### Fetch properties
api = MPRester(api_key='12345')
data = api.query(criteria, ['formula', 'formation_energy_per_atom','band_gap'])
