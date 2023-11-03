import os
import shutil
import glob
import numpy as np
from itertools import zip_longest
import multiprocessing as mp
import time
from datetime import datetime, timedelta
from collections.abc import Sequence 
from pymatgen.symmetry.analyzer import SpacegroupAnalyzer
from pymatgen.core.structure import Structure
from pymatgen.io.vasp.outputs import Vasprun


def sort_sites(struc):
    """Sort sites of a pymatgen structure by coordinates and species. Useful for ensuring distorted structure variants are comparable/interpolatable.
    Args:
        struc (Structure): structure
    Returns:
        Structure: sorted structure
    """
    coords = np.array(struc.cart_coords)
    species = np.array(struc.species)
    sorted_indices = np.lexsort((coords[:,2], coords[:,1], coords[:,0], species))
    return Structure.from_sites([struc[i] for i in sorted_indices])


def gen_mod_struc(phon_dir, labels, kpts, indices, disps, moddims):
    """Generate a single modulated structure from a directory containing a 
    complete phonopy calculation.
    Args:
        phon_dir (str): Path to phonopy directory
        labels (list): List of labels for each modulation
        kpts (list): List of k-points for each modulation
        indices (list): List of indices for each modulation
        disps (list): List of displacements for each modulation
        moddims (list): List of modulation dimensions
    Returns:
        struc (Structure): Modulated structure
        (str): Path to modulated structure directory
    """
    og_dir = os.getcwd()
    mods = [f'{label}{index}' for label,index in zip(labels,indices)]
    subdir = f'mod_{"_".join(mods)}'
    moddir = '/'.join(phon_dir.split('/')[:-1] + ['modulation'])
    os.chdir(moddir)
    os.makedirs(subdir, exist_ok=True)
    os.chdir(subdir)
    ### Create modulation config file
    with open('mod.conf', 'w+') as f:
        shutil.copy(f'{phon_dir}/phonopy_disp.yaml', '.')
        shutil.copy(f'{phon_dir}/FORCE_SETS', '.')
        moddim_str = " ".join([str(i) for i in moddims])
        mod_line = f'MODULATION = {moddim_str}'
        for kpt, index, disp in zip(kpts, indices, disps):
            mod_line += f', {kpt} {index} {disp}'
        f.write(mod_line)
    ### Generate, reduce, and sort the modulated structure
    os.system(f'phonopy mod.conf')
    struc = Structure.from_file('MPOSCAR')
    sga = SpacegroupAnalyzer(struc, symprec=1E-4)
    print(f'{subdir},  SG = {sga.get_space_group_symbol()} ({sga.get_space_group_number()})')
    struc = sga.get_primitive_standard_structure()
    struc = sort_sites(struc)
    os.chdir(og_dir)
    return struc, f'{moddir}/{subdir}'


def check_symmetry(struc):
    print("\nSymmetry for {} \nPrec \tAngle_tol \tSG Sym\tSG Num".format(file))
    for tol, angle_tol in [(0.000001, 0.01), (0.00001, 0.1), (0.0001, 0.1), (0.0001, 1), (0.001, 2), (0.01, 5), (0.1, 5), (1,5)]:
        sg = sga(struc, symprec=tol, angle_tolerance=angle_tol)
        sgSym = sg.get_space_group_symbol()
        sgNum = sg.get_space_group_number()
        print("{}\t{}\t{}\t{}".format(str(tol), str(angle_tol), sgSym, str(sgNum)))


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


def flatten(l):
    for el in l:
        if isinstance(el, Sequence) and not isinstance(el, (str, bytes)):
            yield from flatten(el)
        else:
            yield el


def path2name(path):
    return path.split('/')[-1]


def exec_parallel(func, args, multi_arg=False, verbose=False):
    if verbose: start = time.time()
    with mp.Pool(processes=mp.cpu_count()-1) as pool:
        if multi_arg:  results = pool.starmap(func, args)
        else:          results = pool.map(func, args)
    if verbose: print(f'{func.__name__}: {timedelta(seconds=(time.time()-start))}')
    return results


def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx
    args = [iter(iterable)] * n
    return zip_longest(fillvalue=fillvalue, *args)


def uniquify(seq, id_func=None):
    """Remove duplicates while preserving order
    """
    if id_func is None: 
        def id_func(x): return x 
    seen = {} 
    result = [] 
    for item in seq: 
        marker = id_func(item) 
        if marker in seen: continue 
        seen[marker] = 1 
        result.append(item) 
    return result
