from ase.calculators.vasp import VaspChargeDensity


vchg =  VaspChargeDensity(filename =  'CHGCAR' )
atoms = vchg.atoms[0] # ase atoms object

cell = atoms.get_cell() # cell objects can be treated like 3x3 numpy array with extra properties
vector0 = cell[0] # like this

charge_density = vchg.chg[0] # returns 3d numpy array of charge density
spin_density     = vchg.chgdiff[0] # spin density
