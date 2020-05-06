from pymatgen.symmetry.analyzer import SpacegroupAnalyzer as sga
from pymatgen.core.structure import IStructure
import sys

#Usage: python symmcheck.py *structure file*
#Output: prints space group symbol and number 
# structure file can be any format accepted by pymatgen's IStructure constructor

def main():
    files = sys.argv[1:]
    for file in files:
        print("\nSymmetry for {} \nPrec \tAngle_tol \tSG Sym\tSG Num".format(file))
        for tol, angle_tol in [(0.000001, 0.01), (0.00001, 0.1), (0.0001, 0.1), (0.001, 1), (0.01, 1), (0.1, 1)]: 
            struc = IStructure.from_file(file)
            sg = sga(struc, symprec=tol, angle_tolerance=angle_tol)
            sgSym = sg.get_space_group_symbol()
            sgNum = sg.get_space_group_number()
            print("{}\t{}\t{}\t{}".format(str(tol), str(angle_tol), sgSym, str(sgNum)))

if __name__ == "__main__":
    main()
