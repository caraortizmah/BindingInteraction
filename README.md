# BindingInteraction

```
    Date: 04/18/18
    Author: Carlos Andrés Ortiz Mahecha
```

`BindingInteraction` is pipeline software that manages and uses other programs to do some tasks 
related to calculating protein peptides receptor-ligand binding energy in the field of computational chemistry.
BindingInteraction has been applied to receptor-ligand complexes, such as Major Histocompatibility
Complex class II (MHC II) proteins. 
You can therefore extrapolate it to other approaches (i.e. MHC-like). 

`BindingInteraction` uses some programs and does several tasks detailed below:

     1. Dowser and DowserX softwares for fitting waters into a molecular structure.
     2. MOPAC software for optimizing geometries having dowsed waters.
     3. Dunbrack library on Chimera software for substituting residues for others
         specifically selected by the user. 
     4. Propka 3.1 for assigning charges to molecular structures.
     5. GAMESS software for calculating energies using FMO-DFTB3 theory level.

Calculations at FMO-DFTB3 theory level must have been fragmented by another program.
In our case, that program is Facio. However, Facio is not controlled by `BindingInteraction`
due to this program's closed source license.


## BindingInteraction v1.0

The aim of the `BindingInteraction` pipeline is to automate tasks in computational chemistry
requiring several replications for calculating binding energies in receptor-ligand complexes.

This pipeline is open source (see the LICENSE file for details).


### Download

To get the git version type

    $ git clone https://github.com/caraortizmah/bindinginteraction.git


### Documentation and usage

All information for installing the pipeline can be obtained by typing:

    $ make howto
    
### Preliminary issues

Install Dowser: oficial page is no longer working properly ([Hermans Dowser](http://danger.med.unc.edu/hermans/dowser/dowser.htm) - ) but you can donwload through github (https://github.com/caraortizmah/dowser).

### Installation

For installing the `BindingInteraction` pipeline, follow the next steps:

1st step: Install python requirements if necessary (it could take several minutes)

    $ make require
    
2nd step: Configure the installation program and scratch path

    $ ./configure -p 'program_path' -s 'scratch_path'

3rd step: Prepare folders and other bash programs before installing BindingInteraction

    $ make init
    
4th step: Install BindingInteraction

    $ sudo python setup.py install
    

### Requirements

* [Python 2.7 or higher](https://www.python.org/downloads/) - Page of python

* [VMD](https://www.ks.uiuc.edu/Research/vmd/) - Page of VMD
   
* [Dowser plugin](http://www.ks.uiuc.edu/Research/vmd/plugins/dowser/) - Dowser in VMD
   
* [MOPAC 2016](http://openmopac.net/Download_MOPAC_Executable_Step2.html) - Page of MOPAC
   
* [Chimera](https://www.cgl.ucsf.edu/chimera/download.html) - Page of Chimera
   
* [Propka-3.1](https://github.com/jensengroup/propka-3.1.git) - GitHub of Propka-3.1
   
* [GAMESS](https://www.msg.chem.iastate.edu/GAMESS/download/register/) - Gordon Group 
   
* [Facio FMO util](http://zzzfelis.sakura.ne.jp/) - Page of Facio

