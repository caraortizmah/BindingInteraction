#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program calls and executes chimera without graphical environment

chimera="/opt/UCSF/Chimera64-1.9/bin/chimera"  # Path of chimera program

$chimera --nogui --script select_waters.py # executing chimera without graphical enviroment using a pyhton script

./script_editingwaters.sh 1BX2_org_geom_chim.pdb org_coordinates.arc

