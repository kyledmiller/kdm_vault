############################
#  K-point Grid Generator  #
############################

K-point Grid Generator utilizes informatics to help generate efficient k-point 
grids for plane-wave basis DFT calculations. Based on our benchmarking results 
on 102 randomly selected materials from the ICSD database, calculations using 
our grid are about 2 time faster than those using the common Monkhorst-Pack 
grid.

#######################
How to Use the Program
#######################

A. Configure the application

Inside the folder, users will find three components necessary for running this 
application: the execution script "getKPoints", the executable jar 
"GridGenerator.jar" and the k-point grids database "minDistanceCollection".

Since the program is Java based and has been pre-built, there are only few
configurations that need to be set:

1. JAR_PATH
This variable has a value of the path to the executable jar. For example, a 
user, who has untarred the tarball at his/her home directory, should use 
the value:

    JAR_PATH="/home/<user_name>/k-pointGridGenerator"

We suppose the minDistanceCollection folder is at the same place where the jar
has been put, and it's the default file system hierarchy when the tarball is 
decompressed. If users move the database to somewhere else, he/she should also
change the variable "LATTICE_COLLECTIONS" to the customized path.

2. CALL_SERVER_IF_LOCAL_MISSING="FALSE"
It determines whether to call the server when the script cannot find a jar
file at the configured path or Java is not installed. The default value is 
"FALSE". If users want the script to call the server when calling jar failed,
change its value to "TRUE".

Then you are all set!

You can call the application by executing the script getKPoints. We recommend
users to put the script at ~/bin. This way you can use tab auto-completion to 
call the script.

B. Use the Application

Current application has a stable support for VASP, but Quantum Espresso support
is coming under way. 

First, users should have a PRECALC file. It is the input file for the program.
The basic parameters are "INCLUDEGAMMA" and "MINDISTANCE". The first one's 
name is already suggestive. The second variable has the unit of Angstroms 
and determines the size of k-point grid. It is the minimum periodic distance 
of the superlattice, whose relation with the returned k-point grid follows 
the Born-von Karman Boundary Condition used in the Bloch Theorem. Our 
application could find the grid with the fewest number of symmetrically 
irreducible k-points, given a specific MINDISTANCE. An example of the PRECALC
file is:
    INCLUDEGAMMA=AUTO
    MINDISTANCE=28.1

Then, put the PRECALC file at the same folder as VASP input files (INCAR, 
POSCAR). Then you can call the script 
    
    getKPoints

and will see a KPOINTS file ready for use in calculation.

------------------------------------------------------------------------------
For more information about the theory behind the K-point Grid Generator, 
check our group website at http://muellergroup.jhu.edu, and our paper 
"Efficient generation of generalized Monkhorst-Pack grids through the use of 
informatics.".

