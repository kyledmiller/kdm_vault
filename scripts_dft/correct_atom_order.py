#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Kyle Miller
"""

import sys
import os

def main():
    

    # Create destination directory
    cwd = os.getcwd()
    path = cwd+'/reordered/'
    try:
        os.mkdir(path)    
    except:
        pass
    
    file_names = sys.argv[1:]
    
#    input_str = input("Type the elemental symbols in desired order separated by spaces.\n")
    input_str = 'Mg Ta O'
    elem_order = input_str.split(' ')


    for file_name in file_names:
        elem_dict = { i : list([]) for i in elem_order }
    
        with open(file_name) as file:
            lines = file.readlines()
        
        heading = lines[:8] 
        positions = lines[8:]
        
        # Reorder heading
        elems = heading[5].strip('\n').split(' ')
        counts = heading[6].strip('\n').split(' ')
        count_dict = {elems[i] : counts[i] for i in range(len(elem_order))}
        
        new_elems = ''
        new_counts = ''
        for elem in elem_order:
            new_elems += elem + ' '
            new_counts += count_dict[elem] + ' '
        
        heading[5] = new_elems + '\n'
        heading[6] = new_counts + '\n'
        
        # Reorder atom positions
        for position in positions:
            symbol = position.split(' ')[-1][:-1]
            if elem_dict[symbol] == None:
                elem_dict.update({symbol:position})
            else:
                elem_dict[symbol].append(position)
        
        # Reconstruct POSCAR
        output = ''
        for line in heading:
            output += line
        for key in elem_dict.keys():
            lines = elem_dict[key]
            for line in lines:
                output += line
#        print('asdfasdfasdf')
#        print(path + file_name)
        with open(path + file_name, 'w+') as file:
            file.write(output)

if __name__ == "__main__":
    main()