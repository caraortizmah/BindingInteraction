#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#
#*************************************

echo "**********Setting external program paths**********"

read -p "Enter the absolute MOPAC path name : " mopac_path
read -p "Enter the absolute Propka 3.1 path name : " pka_path
read -p "Enter the absolute VMD path name : " vmd_path
read -p "Enter the absolute OpenBabel path name : " babel_path
read -p "Enter the absolute Chimera path name : " chimera_path
read -p "Enter the absolute GAMESS path name (optional): " gamess_path

if [ -z "$gamess_path" ]; then
  gamess_path="no-gamess"
fi

cat << EOF > pro_paths.log
***List of external program directories:
----You can change paths only modifying this file
!!!!Do not remove other parts of this file
***PATHS
MOPAC path : $mopac_path
Propka 3.1 path : $pka_path
VMD path : $vmd_path
GAMESS path : $gamess_path
Babel path : $babel_path
Chimera path : $chimera_path
***
EOF
