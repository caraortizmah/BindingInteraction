# BindingInteraction

```
    Date: 04/18/18
    Author: Carlos Andrés Ortiz Mahecha
    
```
[comment]: <> (****)

[comment]: <> (Modification: 12/02/20)
[comment]: <> (comment:)
[comment]: <> (12/02/20 - Substantial changes in the installation and new kind of test based on MHC I results)
[comment]: <> (Old install version were removed while is fixed)

[comment]: <> (****)

`MHC Binding Interaction (MHCBI)` is a pipeline software that manages and uses other programmes to perform some tasks related to calculating protein peptide receptor-ligand binding energy in the field of computational chemistry. 
The MHCBI has been used with receptor-ligand complexes, such as major histocompatibility complex (MHC) proteins. 
It can therefore be extrapolated to other non-covalent interaction systems (i.e. MHC-like structures).

The `MHCBI` uses some programmes and does several tasks as detailed below:

     1. Dowser and DowserX software for putting water molecules into a protein structure.
     2. MOPAC software for several kinds of calculation using semi-empirical quantum methods (SQM), such as optimisation geometries and single point energies, as in this methodology.
     3. Dunbrack library on graphical interface Chimera software for substituting residues for others selected by the user. 
     4. Propka 3.1 for assigning charge to a protein structure.
     5. GAMESS software for calculating binding energies using the Fragment Molecular Orbital method (FMO) at SQM DFTB3.

When the `MHCBI` uses GAMESS software, molecules must be fragmented prior to the single point energy calculation. These fragmentations are performed by a graphical user interface programme known as Facio; however, Facio is not controlled by `MHCBI` in script mode due to this programme is non-open source licence.


## MHCBI v2.0

The aim of the `MHCBI` pipeline is to automate tasks regarding binding energy methodology for MHC-like systems requiring several replications for estimating receptor-ligand interactions.
This pipeline is open source GPL-3.0 License and intended to be adapted, modified or used according to user needs.

### Download

To get the git version type

    $ git clone https://github.com/caraortizmah/bindinginteraction.git


[comment]: <> (### Documentation and usage)

[comment]: <> (All information for installing the pipeline can be obtained by typing:)

[comment]: <> (    $ make howto)
    
### Preliminary issues

Install Dowser: oficial page is no longer working properly ([Hermans Dowser](http://danger.med.unc.edu/hermans/dowser/dowser.htm) - ) but you can donwload it through github (https://github.com/caraortizmah/dowser).

### Installation

The `MHCBI` pipeline is mostly written in Shell script and includes Python and Tcl languages for managing programme operations in graphical interface software, such as Dowser in VMD and Dunbrack’s library in Chimera.
For installing the `MHCBI` pipeline, follow the next steps:

[comment]: <> (Option 1:)

1st step: Initialize the `MHCBI` pipeline

    $ chmod +x init.sh
    $ ./init.sh

2nd step: Configure all pipeline scripts and set paths for external program and work directory

    $ ./setup.sh
    
3nd step: Complete all steps in order
 
    1. Paths for the `MHCBI` pipeline, work directory and PDB structure directory. 
    2. Paths for required external programs.
    3. Configuring pipeline for running.
    4. Testing pipeline.

4th step: Follow the instructions for running pipeline in the designated place 

    $ ./run.sh

Optional step: For cleaning pipeline to re-configure or make any git procedure

    $ cd MHCBI_path (in MHCBI directory)
    $ ./clean.sh


[comment]: <> (Option 2:)

[comment]: <> (1st step: Install python requirements if necessary it could take several minutes $ make require)
    
[comment]: <> (2nd step: Configure the installation program and scratch path $ ./configure -p 'program_path' -s 'scratch_path')

[comment]: <> (3rd step: Prepare folders and other bash programs before installing the `MHCBI` $ make init)
    
[comment]: <> (4th step: Install BindingInteraction    $ sudo python setup.py install)


### Requirements - Linux text processing tool

* Grep 
* Cut
* Awk
* Sed

### Requirements

* [Open Babel](http://openbabel.org/wiki/Main_Page) - Open Babel page

* [Python 2.7 or higher](https://www.python.org/downloads/) - Python page

* [VMD version 1.9.1 (February 1, 2012)](https://www.ks.uiuc.edu/Research/vmd/) - VMD page
   
* [Dowser plugin](http://www.ks.uiuc.edu/Research/vmd/plugins/dowser/) - Dowser in VMD
   
* [MOPAC 2016](http://openmopac.net/Download_MOPAC_Executable_Step2.html) - MOPAC page
   
* [Chimera](https://www.cgl.ucsf.edu/chimera/download.html) - Chimera page
   
* [Propka-3.1](https://github.com/jensengroup/propka-3.1.git) - GitHub of Propka-3.1

    Optional
   
* [GAMESS](https://www.msg.chem.iastate.edu/GAMESS/download/register/) - Gordon Group page
   
* [Facio FMO util](http://zzzfelis.sakura.ne.jp/) - Facio page


### Reference and Citation

Please cite the following reference in publications:

*   Ortiz-Mahecha, Carlos A., Bohórquez, Hugo J., Agudelo, William A., Patarroyo, Manuel A., Patarroyo, Manuel E. and Suárez, Carlos F. ["Assessing peptide binding to MHC II: An accurate semi-empirical quantum mechanics-based proposal."](https://doi.org/10.1021/acs.jcim.9b00672) Journal of Chemical Information and Modeling, (2019). - DOI: 10.1021/acs.jcim.9b00672
