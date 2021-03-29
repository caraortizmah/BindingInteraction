#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the pipeline configuration for paths through Shell Script.
#*************************************

echo "**********Setting work paths**********"

read -p "Enter the pdb structure path : " pdb_path
read -p "Enter the pdb structure name : " pdb_name
read -p "Enter the to-do work path : " work_dir
read -p "Enter the name of your work : " work_name

cat << EOF > paths.log
***List of directories:
----You can change paths only modifying this file
!!!!Do not remove other parts of this file
***PATHS
PDB path : $pdb_path
PDB name : $pdb_name
Work path : $work_dir
Work name : $work_name
***
EOF
