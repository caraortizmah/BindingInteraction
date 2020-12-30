# MHCBI Test

`MHCBI test` is aimed to prove that pipeline was configured and uses all specialized programs correctly. `The MHCBI pipeline` has two version test: shortened 1BX2 and 3OXS PDB structures.
     Shortened 1BX2 is a MHC class II molecule constituted by a 14-residue peptide as a ligand and a reduced protein binding region (having a alpha helical form) as a receptor.
     Shortened 3OXS is a MHC class I molecule constituted by a 10-residue peptide as a ligand and a protein binding region (including alpha helical and beta sheet form) as a receptor.
     
Where the shortened 1BX2 is the `short test` and the shortened 3OXS is the `straight test`. They differ in the size (3OXS is about double residue number).

In test folder there are two folders named as `si_short` and `si_straight` each folder contains the expected PDB structures as outputs for calculating binding energies using FMO in GAMESS.
Number of PDB structures in those folders are the same accodring to the GAMESS input files ready for calculating binding energy using DFTB3 under FMO.
