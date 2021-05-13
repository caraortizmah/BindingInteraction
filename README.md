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
     2. MOPAC software for several kinds of calculation using semi-empirical quantum methods (SQM), 
        such as optimisation geometries and single point energies, as in this methodology.
     3. Dunbrack library on graphical interface Chimera software for substituting residues for others selected by the user.
     4. PROPKA 3.1 for assigning charges to a protein structure.
     5. GAMESS software for calculating binding energy using the Fragment Molecular Orbital method (FMO) at SQM DFTB3.

Molecules must be fragmented prior to single point energy calculation, when the `MHCBI` uses GAMESS software. Such fragmentation is performed by a graphical user interface programme known as Facio; however, Facio is not controlled by `MHCBI` in script mode due to this program having a non-open-source licence.


## MHCBI 2.0.0

The aim of the `MHCBI` pipeline is to automate tasks regarding binding energy methodology for MHC-like systems requiring several replications for estimating receptor-ligand interactions.
This pipeline is an open source tool (GPL-3.0 Licence) and is intended to be adapted, modified or used according to user needs.

### Download

To get the git version type

    $ git clone https://github.com/caraortizmah/bindinginteraction.git

### Installation

The `MHCBI` pipeline is mostly written in Shell script and includes Python and Tcl languages for managing programme operations in graphical interface software, such as Dowser in VMD and Dunbrack’s library in Chimera.
Follow the steps below for installing and running the `MHCBI` pipeline:

Follow the instructions which appear while executing every step:


1st step: initialize the `MHCBI` pipeline

    $ chmod +x init.sh
    $ ./init.sh

2nd step: configure all pipeline scripts and set paths for external programs

    $ ./setup.sh

  Complete all setup steps in order

    1. Paths for all the required external programs
    2. Test the pipeline

3rd step: configure a work directory and run the pipeline

    $ ./pre-run.sh

  Complete all pre-run steps in order

    1. Paths for the work and PDB structure.
    2. Configure folders and directories for the user project.
    3. Run pipeline on user project.

## Notepadding

For further information read all documentation available in `docs` folder.


[comment]: <> (2nd step: Configure the installation program and scratch path $ ./configure -p 'program_path' -s 'scratch_path')
[comment]: <> (3rd step: Prepare folders and other bash programs before installing the `MHCBI` $ make init)
[comment]: <> (4th step: Install BindingInteraction    $ sudo python setup.py install)


### Requirements - Linux text processing tool

* grep
* cut
* awk
* gawk
* sed
* vim

### Requirements - Specialized softwares

* [Open Babel 2.3.1](https://openbabel.org/docs/dev/Installation/install.html) or [2.4.0](https://sourceforge.net/projects/openbabel/files/openbabel/2.4.0/) - Open Babel

* [Python 2.7 or higher](https://www.python.org/downloads/) - Python page

* [VMD version 1.9.1 (February 1, 2012) or higher](https://www.ks.uiuc.edu/Research/vmd/) - VMD page

* [VMD Dowser plugin](http://www.ks.uiuc.edu/Research/vmd/plugins/dowser/) - Version 1.1

* [Dowser](https://github.com/caraortizmah/dowser) - non-Official GitHub repository.

* [MOPAC 2016](http://openmopac.net/Download_MOPAC_Executable_Step2.html) - MOPAC page

* [Chimera](https://www.cgl.ucsf.edu/chimera/download.html) - Chimera page

* [PROPKA-3.1](https://github.com/jensengroup/propka-3.1.git) - PROPKA-3.1 GitHub

    Optional

* [GAMESS](https://www.msg.chem.iastate.edu/GAMESS/download/register/) - Gordon Group page

* [Facio FMOutil](http://zzzfelis.sakura.ne.jp/) - Facio page


### Additional handling

You can test the `MHCBI` pipeline by downloading and using the following [virtual machine](http://www.fidic.org.co/pagina/MHCBI.zip). 
This virtual machine has an Ubuntu 20.04 installation having all the requirements needed for using the pipeline.
 

## Referring to and citing the `MHCBI` pipeline

Please cite the following reference in publications:

*   Ortiz-Mahecha, Carlos A., Bohórquez, Hugo J., Agudelo, William A., Patarroyo, Manuel A., Patarroyo, Manuel E. and Suárez, Carlos F. ["Assessing peptide binding to MHC II: An accurate semi-empirical quantum mechanics-based proposal."](https://doi.org/10.1021/acs.jcim.9b00672) Journal of Chemical Information and Modeling, 2019, 59(12), 5148-5160. - DOI: 10.1021/acs.jcim.9b00672
*   Ortiz-Mahecha, Carlos A., Agudelo, William A., Patarroyo, Manuel A., Patarroyo, Manuel E. and Suárez, Carlos F. ["MHCBI: a pipeline for calculating peptide-MHC binding energy using semi-empirical quantum mechanical methods with explicit/implicit solvent models."](https://doi.org/10.1093/bib/bbab171) Briefings in Bioinformatics, 2021, 1-8. DOI: 10.1093/bib/bbab171
