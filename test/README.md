# MHCBI pipeline test

`MHCBI test` is aimed to prove that pipeline was configured and uses all specialized programs correctly.

## Test core

`The MHCBI pipeline` has two version tests: shortened 1BX2 and 3OXS PDB structures.

     1. Shortened 1BX2 is a MHC class II molecule constituted by a 14-residue peptide as a ligand and a reduced protein binding region (having an alpha helical form) as a receptor.

     2. Shortened 3OXS is a MHC class I molecule constituted by a 10-residue peptide as a ligand and a protein binding region (including alpha helical and beta sheet forms) as a receptor.

The shortened 1BX2 is the `short test` and the shortened 3OXS is the `straight test`. They differ in the size (3OXS is about double residue number).

## Additional files

In test folder there are two folders named as `si_short` and `si_straight` each folder contains the expected PDB structures (as `MOPAC outputs`) obtained during the three stages (optimizations, mutations and calculations) using MOPAC.
Additionally, these folders have FMO GAMESS inputs obtained using GUI Facio in default conditions for fragmenting PDB structures (`MOPAC outputs`).
Only for testing the `MHCBI pipeline` those GAMESS input files are explicitly inside test section for calculating binding energies using FMO in GAMESS.
Number of PDB structures in those folders are the same according to the GAMESS input files ready for calculating binding energy using DFTB3 under FMO.
For running your own projects you need GUI Facio or another tool for converting a PDB structure into a FMO GAMESS input file.
