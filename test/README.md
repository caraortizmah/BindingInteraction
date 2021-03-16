# The MHCBI pipeline test

The `MHCBI test` is aimed at testing that the pipeline uses all the specialized programs and has been correctly configured.

## Notepadding

First, ensure that you have read all documentation available in the `docs` folder prior to attempting to use this specific information.

## Test core

The `MHCBI pipeline` has two test versions: shortened 1BX2 and 3OXS PDB structures.

     1. Shortened 1BX2 is an MHC class II molecule constituted by:
         a 14-residue peptide as a ligand and 
         a reduced protein binding region (having an alpha helical form) as receptor.

     2. Shortened 3OXS is an MHC class I molecule constituted by:
         a 10-residue-long peptide as ligand and 
         a protein binding region (including alpha helical and beta sheet forms) as receptor.

Shortened 1BX2 is the `short test` and shortened 3OXS the `straight test`. They differ in size (3OXS has about double the amount of residues).

## Additional files

The test folder contains two folders named as `si_short` and `si_straight`.
Each folder contains the expected PDB structures (as `MOPAC outputs`) obtained during the third stage end (calculations folder) using MOPAC.

Additionally, these folders have FMO GAMESS input obtained using GUI Facio in default conditions for fragmenting PDB structures (`MOPAC outputs`).
Only for testing the `MHCBI pipeline` those GAMESS input files are contained inside the `test` folder for calculating binding energies (BE) using FMO in GAMESS.

The amount of PDB structures in these folders are equal to the amount of GAMESS input files ready for calculating BE using DFTB3 under FMO framework.
For running your own `projects` you need GUI Facio for converting a PDB structure into an FMO GAMESS input file.
