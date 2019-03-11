# BindingInteraction

```
    Date: 03/07/19
    Author: Carlos Andrés Ortiz Mahecha
```

`BindingInteraction` is a pipeline software that manages and uses other programs to do some tasks 
related to calculate receptor-ligand binding energy of proteins in computational chemistry field.

`BindingInteraction` uses some programs and does several tasks detailed below:

     1. Dowser and DowserX softwares for putting waters on a molecular structure
     2. MOPAC software for optimizing geometries with dowsed waters.
     3. Dunbrack library on Chimera software for substituting residues for others
         selected by the user. 
     4. Propka 3.1 for assigning charges on molecular structure.
     5. GAMESS software for calculating energies using FMO-DFTB3 theory level.

Calculations at FMO-DFTB3 theory level need to be fragmented previously by other program.
In our case, that program is Facio. However, Facio is not controlled by `BindingInteraction`
due to the closed source license of this program.


# BindingInteraction v1.0

The aim of `BindingInteraction` pipeline is to automate tasks in computational chemistry that
requires several replications to calculate binding energies in receptor-ligand complexes.
This pipeline is open source (see the LICENSE file for details).


## Download

To get the git version do

    $ git clone https://github.com/caraortizmah/bindinginteraction.git


## Documentation and usage

All information is at:

    $ cd doc
    $ make html

## Installation

For installing `BindingInteraction` pipeline, you just run:

    $ sudo python setup.py install

## Requirements

    * [Python 2.7 or higher](https://www.python.org/downloads/) - Page of python
    * [Dowser software](http://www.ks.uiuc.edu/Research/vmd/plugins/dowser/) - Dowser software
    * [MOPAC 2016](http://openmopac.net/Download_MOPAC_Executable_Step2.html) - Page of MOPAC
    * [Chimera](https://www.cgl.ucsf.edu/chimera/download.html) - Page of Chimera
    * [Propka-3.1](https://github.com/jensengroup/propka-3.1.git) - GitHub of Propka-3.1
    * [GAMESS](https://www.msg.chem.iastate.edu/GAMESS/download/register/) - Gordon Group 
    * [Facio FMO util](http://zzzfelis.sakura.ne.jp/) - Page of Facio

## Citation

Users of `BindingInteraction` pipeline must cite the following references:


    * doi: xxxx
    * doi: xxxx
