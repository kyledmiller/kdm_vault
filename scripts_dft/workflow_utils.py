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


def sort_sites(struc, unwrap_tol=0.05):
    """Sort sites of a pymatgen structure by coordinates and species. Useful for ensuring distorted structure variants are comparable/interpolatable.
    Args:
        struc (Structure): structure
        unwrap_tol (float): maximum distance from upper edge of unit cell
                            below which sites will be unwrapped to negative 
                            coordinates (fractional units) 
    Returns:
        Structure: sorted structure
    """
    #abc = struc.lattice.lengths
    coords = np.array(struc.frac_coords)

    ### Wrap very high coords to negative to avoid sort errors
    for i in range(coords.shape[0]):
        for j in range(coords.shape[1]):
            if coords[i,j] + unwrap_tol >= 1:
                #print(f'sort_sites: at edge: {coords[i,j]}')
                coords[i,j] = coords[i,j] - 1 
                #print(f'sort_sites: wrapped: {coords[i,j]}')
    species = np.array(struc.species)
    sorted_indices = np.lexsort((coords[:,0], coords[:,1], coords[:,2], species))
    #print(abc)
    #print(coords)
    return Structure.from_sites([struc[i] for i in sorted_indices])


def check_symmetry(struc):
    print("Prec \tAngle_tol \tSG Sym\tSG Num")
    for tol, angle_tol in [(0.000001, 0.01), (0.00001, 0.1), (0.0001, 0.1), (0.0001, 1), (0.001, 2), (0.01, 5), (0.1, 5), (1,5)]:
        sga = SpacegroupAnalyzer(struc, symprec=tol, angle_tolerance=angle_tol)
        sgSym = sga.get_space_group_symbol()
        sgNum = sga.get_space_group_number()
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
                   parse_potcar_file=False, exception_on_bad_xml=False
                   ).converged:
            return True
        else: return False
    except: return False


def check_converged_detailed(outdir, verbose=False):
    """Returns {'elec':converged_electronic, 'ion': converged_ionic}
    """
    try:
        vr = Vasprun(f'{outdir}/vasprun.xml', parse_dos=False, parse_eigen=False,
                   parse_potcar_file=False, exception_on_bad_xml=False)
        conv_dict = {'elec': vr.converged_electronic, 'ion': vr.converged_ionic}
        if verbose: print(f'{outdir}\t{conv_dict}')
        return conv_dict
    except:
        conv_dict = {'elec': False, 'ion': False}
        if verbose: print(f'{outdir}\t{conv_dict}\tException')
        return conv_dict


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


def exec_parallel(func, args, multi_arg=False, verbose=False, nproc:int=0):
    if verbose: start = time.time()
    if nproc < 1: nproc = mp.cpu_count() - nproc
    with mp.Pool(processes=nproc) as pool:
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
