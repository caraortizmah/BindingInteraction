
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This python program calls some routines in chimera to creates the substitutions using Dunbrack library


import os
from chimera import runCommand as rc # use 'rc' as shorthand for runCommand
from chimera import replyobj # for emitting status messages
   
# change to folder with data files
os.chdir("/home/caom/2018/1BX2_script/mutation_step/")


rc ("open 1BX2_for_mutations.pdb") # opening the original geometry
rc ("swapaa Ala #0:11.p") # swapping a residue
rc ("write format pdb 0 1BX2_geom_chim-A11.pdb") #writing the new format
rc ("close #0") # closing .pdb file

#repeating the operation in the others residues

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:12.p")
rc ("write format pdb 0 1BX2_geom_chim-A12.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:13.p")
rc ("write format pdb 0 1BX2_geom_chim-A13.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:14.p")
rc ("write format pdb 0 1BX2_geom_chim-A14.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:15.p")
rc ("write format pdb 0 1BX2_geom_chim-A15.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:16.p")
rc ("write format pdb 0 1BX2_geom_chim-A16.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:17.p")
rc ("write format pdb 0 1BX2_geom_chim-A17.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:18.p")
rc ("write format pdb 0 1BX2_geom_chim-A18.pdb")
rc ("close #0")

rc ("open 1BX2_for_mutations.pdb")
rc ("swapaa Ala #0:19.p")
rc ("write format pdb 0 1BX2_geom_chim-A19.pdb")
rc ("close #0")
