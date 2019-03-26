from pymatgen.symmetry.analyzer import SpacegroupAnalyzer as sga
from pymatgen.core.structure import IStructure
import sys

#Usage: python symmcheck.py *structure file*
#Output: prints space group symbol and number 
# structure file can be any format accepted by pymatgen's IStructure constructor

def main():
    files = sys.argv[1:]
    for file in files:
        struc = IStructure.from_file(file)
        sg = sga(struc)
        sgSym = sg.get_space_group_symbol()
        sgNum = sg.get_space_group_number()
        print('Space group for {} is {} ({})'.format(file,sgSym,str(sgNum)))

if __name__ == "__main__":
    main()
