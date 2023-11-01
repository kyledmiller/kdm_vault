import os
import shutil
from pymatgen.io.vasp.outputs import Vasprun
import glob


def clean_and_run():
    os.makedirs('old', exist_ok=True)
    old_files = glob.glob('slurm*')
    for f in old_files:
        shutil.move(f, 'old/')
    os.system('sbatch submit.sh')


def check_overwrite(outdir):
    """Check for overwrite problem, return True if there is an overwrite problem or
    False if we can go ahead
    """
    if os.path.exists(f'{outdir}/OUTCAR'):
        answer = input(f'Overwrite {outdir}? (y/n): ')
        if answer != 'y' and answer != 'Y':
            return True
    return False

               
def check_converged(outdir):
    """Check vasprun file, return if it's converged
    """
    try:
        if Vasprun(f'{outdir}/vasprun.xml', parse_dos=False, parse_eigen=False,
                   parse_potcar_file=False, exception_on_bad_xml=True
                   ).converged:
            return True
        else: return False
    except: 
        return False


def make_primitive(struc_name):
    if not os.path.exists('PPOSCAR'):
        os.system(f'phonopy --symmetry -c {struc_name}')
        shutil.copy('PPOSCAR', 'POSCAR')
    #sga = SpacegroupAnalyzer(struc)
    #struc = sga.get_primitive_standard_structure()
