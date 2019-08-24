#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .pdb file

chimera="/opt/UCSF/Chimera64-1.9/bin/chimera" #Path of chimera

$chimera --nogui --script SCRIPT_MOPAC_DR1.py #execution of chimera without graphic enviroment

for i in `ls 1BX2_geom_chim-*`
do
  sed -i 's/HETATM/ATOM  /g' "$i" #replacing HETATM by ATOM
done
