### Setup
import osi
from os.path import expanduser
home = expanduser("~")
outfile = std.out
os.environ['VASP_COMMAND'] = f'mpirun -n $SLURM_NTASKS /projects/b1027/VASPmod.5.4.4/vasp_std > {outfile}'
os.environ['VASP_SCRIPT'] = f'{home}/.scripts/run_vasp.py' 

### POSCAR
from ase import io
atoms = io.read('POSCAR', format = 'vasp')
atoms.set_initial_magnetic_moments([0]*8 + [2]*4 + [-2]*4 +[0]*16)

### KPOINTS
import ase.dft.kpoints
kpts = ase.dft.kpoints.monkhorst_pack([3, 3, 3])

### INCAR
from ase.calculators.vasp import Vasp
hub_U_dict = {'Co':{'L': 2, 'U':2}}
calc = Vasp(xc='PBE', setups='recommended', kpts=kpts, gamma=True, ldau_luj=hub_U_dict)
calc.set(prec='Accurate', ediff=1E-7, encut=600, algo = 'Normal', ispin = 2, nelm = 200, lmaxmix = 4)
calc.set(lreal='Auto')
calc.set(nsw = 99999, ediffg = -1E-3, isym=0)

### Initiate calculation
atoms.set_calculator(calc)
energy = atoms.get_potential_energy()
print("Energy:", energy)
forces = atoms.get_forces()
print("Forces:", forces)

### alt way to call vasp
#calc.calculate(atoms)
