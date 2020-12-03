#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the configuration pipeline through Shell Script, a straightforward to use it.
#*************************************

read -p "Enter the MOPAC path name : " mopac_path
read -p "Enter the MHCBI path name : " pipeline_path
read -p "Enter the pdb structure path : " pdb_path
read -p "Enter the pdb structure name : " pdb_name
read -p "Enter the path where to do this work : " work_dir
read -p "Enter the name of your work : " work_name

cat << EOF > paths.log

***List of directories:
----You can change paths only modifying this file
!!!!Do not remove other parts of this file

***PATHS

MOPAC path : $mopac_path
MHCBI path : $pipeline_path
PDB path : $pdb_path
PDB name : $pdb_name
Work path : $work_dir
Work name : $work_name

***

EOF
