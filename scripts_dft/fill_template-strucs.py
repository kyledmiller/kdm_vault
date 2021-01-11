#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan  8 16:07:11 2021

@author: kyledmiller
"""

import sys
import os

target_dir = 'strucs'

if not os.path.exists(target_dir):
    os.makedirs(target_dir)

templates = sys.argv[1:]

template_formula = ['*A', '*B', '*C']
formulas = [['Be','Sb','O'], ['Cr','Sb','O'], ['Ge','Mn','O'], ['Ge','Sn','O'], ['Ir','Cr','O'], 
            ['Ir','Mn','O'], ['Ir','V','O'], ['Mn','Pt','O'], ['Mn','Sn','O'], ['Pt','V','O'],
            ['Re','Fe','O'], ['Re','Mn','O'], ['Re','V','O'], ['Ru','Re','O'], ['Ti','Ir','O'],
            ['Ti','Ta','O'], ['W','Al','O'], ['W','Nb','O']]



for template in templates:
    
    for formula in formulas:
    
        # Read in the file
        with open(template, 'r') as file:
            filedata = file.read()
        
        # Replace the template species
        for i in range(len(template_formula)):
            filedata = filedata.replace(template_formula[i], formula[i])
        
        # Write the file out again
        with open(f'{target_dir}/struc_{template[:-5]}_{formula[0]}{formula[1]}2{formula[2]}6.vasp', 'w') as file:
            file.write(filedata)