#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#
#*************************************

read -p "Enter the MOPAC path : " mopac_path
read -p "Enter the Propka 3.1 path : " pka_path
read -p "Enter the VMD path : " vmd_path
read -p "Enter the GAMESS path : " gamess_path

cat << EOF > pro_paths.log

***List of external program directories:
----You can change paths only modifying this file
!!!!Do not remove other parts of this file

***PATHS

MOPAC path : $mopac_path
Propka 3.1 path : $pka_path
VMD path : $vmd_path
GAMESS path : $gamess_path

***

EOF
