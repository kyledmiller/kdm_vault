from pymatgen.symmetry.analyzer import SpacegroupAnalyzer as sga
from pymatgen.core.structure import Structure
import sys
from workflow_utils import check_symmetry

#Usage: python symmcheck.py *structure file*
#Output: prints space group symbol and number 
# structure file can be any format accepted by pymatgen's IStructure constructor

def main():
    files = sys.argv[1:]
    for file in files:
    
        struc = Structure.from_file(file)
        check_symmetry(struc)
        #print("\nSymmetry for {} \nPrec \tAngle_tol \tSG Sym\tSG Num".format(file))
        #for tol, angle_tol in [(0.000001, 0.01), (0.00001, 0.1), (0.0001, 0.1), (0.0001, 1), (0.001, 2), (0.01, 5), (0.1, 5), (1,5)]: 
        #    sg = sga(struc, symprec=tol, angle_tolerance=angle_tol)
        #    sgSym = sg.get_space_group_symbol()
        #    sgNum = sg.get_space_group_number()
        #    print("{}\t{}\t{}\t{}".format(str(tol), str(angle_tol), sgSym, str(sgNum)))

if __name__ == "__main__":
    main()
