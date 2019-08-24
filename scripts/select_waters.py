#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This python program calls some routines in chimera to save waters in 8-angstrom area from the selected residues of the peptide


import os
from chimera import runCommand as rc # use 'rc' as shorthand for runCommand
from chimera import replyobj # for emitting status messages
   
# change to folder with data files
os.chdir("/home/caom/2018/1BX2_script/waters_step/")

rc ("open 1BX2_org_geom_chim.pdb")
rc ("delete #0: .V & #0: 11-19.P zr > 8") # deleting all molecules in chain V (waters) out of the 8-angstrom area from the selected residues of the peptide
rc ("delete #0: .A,.B,.P,.W") #deleting the rest of the chains
rc ("write format pdb 0 list_waters.pdb") #creating the list of water molecules accepted
rc ("close #0")

