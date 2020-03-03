#!/usr/bin/env python
"""
A script which reads VASP charge density files from spin polarised calculations
and outputs three new files containing the majority spin data, the minority spin
data and the difference between the two.
Depends on ase
"""

import os
import sys
import time
import numpy
from ase.calculators.vasp import VaspChargeDensity

starttime = time.time() 
print("Starting calculation at")
print(time.strftime("%H:%M:%S on %a %d %b %Y"))

if len(sys.argv) != 3:
    print("\n** ERROR: Must specify name of 2 files on command line.")
    print("eg. diffchg.py CHGCAR1 CHGCAR2 .")                                        
    sys.exit(0)

if not os.path.isfile(sys.argv[1]):
    print("\n** ERROR: Input file %s was not found.")% sys.argv[1]
    sys.exit(0)

if not os.path.isfile(sys.argv[2]):
    print("\n** ERROR: Input file %s was not found.")% sys.argv[2]
    sys.exit(0)

# Read information from command line
# First specify location of PARCHG 
chg1 = sys.argv[1].lstrip()
split = chg1.split('.')
if len(split) > 1:
    prefix1 = ''.join(split[0:-1])
    suffix1 = '.' + split[-1]
else:
    prefix1 = split[0]
    suffix1 = ''
    
chg2 = sys.argv[2].lstrip()
split = chg2.split('.')
if len(split) > 1:
    prefix2 = ''.join(split[0:-1])
    suffix2 = '.' + split[-1]
else:
    prefix2 = split[0]
    suffix2 = ''
    
# Open geometry and density class objects
#-----------------------------------------
print("Reading potential data from file %s ..." % chg1,
sys.stdout.flush())
vasp_charge_data = VaspChargeDensity(filename=chg1)
print("done.")
# Check data is spin polarised
if not vasp_charge_data.is_spin_polarized():
    print("\n** ERROR: Input file does not contain spin polarised data.")
    sys.exit(0)
# Make Atoms object and arrays of density data
geomdata1 = vasp_charge_data.atoms[-1]
chgdat1 = vasp_charge_data.chg[-1]

print("Reading potential data from file %s ..." % chg2,
sys.stdout.flush())
vasp_charge_data = VaspChargeDensity(filename=chg2)
print("done.")
# Check data is spin polarised
if not vasp_charge_data.is_spin_polarized():
    print("\n** ERROR: Input file does not contain spin polarised data.")
    sys.exit(0)
# Make Atoms object and arrays of density data
geomdata2 = vasp_charge_data.atoms[-1]
chgdat2 = vasp_charge_data.chg[-1]

# Read in potential data
#------------------------
ngridpts = numpy.array(chgdat1.shape)
totgridpts = ngridpts.prod()
print("Potential stored on a %dx%dx%d grid" % (ngridpts[0],ngridpts[1],ngridpts[2]))
print("Total number of points is %d" % totgridpts)

# Calculate difference
#----------------------------------------
diffchg = (chgdat1 - chgdat2)

# Write out file
#------------------------
parchgfile = 'DIFF_' + prefix1 + '-' + prefix2 + suffix1
print("Writing data to file %s..." % parchgfile,
sys.stdout.flush())
output_charge_data = VaspChargeDensity(filename=None)
output_charge_data.atoms=[geomdata1,]
output_charge_data.chg=[diffchg,]
output_charge_data.write(filename=parchgfile,format="chgcar")
print("done.")

endtime = time.time() 
runtime = endtime-starttime
print("\nEnd of calculation.")
print("Program was running for %.2f seconds." % runtime)
