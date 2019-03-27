from pymatgen.symmetry.analyzer import SpacegroupAnalyzer as sga
from pymatgen.core.structure import IStructure
import sys

#Usage: python symmcheck.py *structure file*
#Output: prints space group symbol and number 
# structure file can be any format accepted by pymatgen's IStructure constructor

def main():
    files = sys.argv[1:]
    for file in files:
	print("Symmetry for {} \nsymprec \tSG Sym\tSG Num".format(file))
        for tol in [0.00001, 0.0001, 0.001, 0.01, 0.1]: 
		struc = IStructure.from_file(file)
        	sg = sga(struc, symprec=tol)
        	sgSym = sg.get_space_group_symbol()
        	sgNum = sg.get_space_group_number()
        	print("{}\t{}\t{})".format(str(tol),sgSym,str(sgNum)))

if __name__ == "__main__":
    main()
