#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan  8 18:51:29 2021

@author: kyledmiller
"""

struc_types = ['Na2SiF6', 'ThTi2O6', 'columbite', 'rosiaite']

systems =   ["BeSb2O6","CrSb2O6","GeMn2O6","GeSn2O6","IrCr2O6","IrMn2O6","IrV2O6","MnPt2O6","MnSn2O6","PtV2O6","ReFe2O6","ReMn2O6","ReV2O6","RuRe2O6","TiIr2O6","TiTa2O6","WAl2O6","WNb2O6"]
mag_sites = ['',       'A',      'B',      '',       'AB',       'AB',     'AB',    'AB',     'A',      'AB',    'AB',     'AB',     'AB',    'AB',     'AB',     'A',      'A',     'AB']

for struc_type in struc_types:
    for system, mag_site in zip(systems, mag_sites):
    
        # Read in the file
        with open(f'template-magmom_{struc_type}.txt', 'r') as file:
            filedata = file.read()
            
        # Replace the template species
        for site in 'ABC':
            if site in mag_site:
                filedata = filedata.replace(f'*{site}', '*3')
            else:
                filedata = filedata.replace(f'*{site}', '*0')
                    
        # Write the file out again
        with open(f'magmom_{struc_type}_{system}.txt', 'w') as file:
            file.write(filedata)