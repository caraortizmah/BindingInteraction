# bindinginteraction-1.0 pipeline

#Date: 03/07/19
#Author: Carlos Andrés Ortiz Mahecha


# This pipeline software manages and uses other programs to do some tasks related to calculate 
#  receptor-ligand binding energy of proteins.

# Detailed programs and tasks that bindinginteraction does are presented below:
#  1. Dowser and DowserX softwares for putting waters on a molecular structure
#  2. MOPAC software for optimizing geometries with dowsed waters.
#  3. Dunbrack library on Chimera software for substituting residues for others selected by the user. 
#  4. Propka 3.1 for assigning charges on molecular structure.
#  5. GAMESS software for calculating energies using FMO-DFTB3 theory level.
# Calculations at FMO-DFTB3 theory level need to be fragmented previously by other program.
# In our case, that program is Facio. However, Facio is not controlled by bindinginteraction
#   due to the closed source license of this program.

# The aim of bindinginteraction pipeline is to automate tasks in computational chemistry
#  that requires several replications to calculate binding energies in receptor-ligand complexes.
# This pipeline is open source.
# Users of bindinginteraction pipeline must cite the following references:

#  1. doi: xxxx
#  2. doi: xxxx
