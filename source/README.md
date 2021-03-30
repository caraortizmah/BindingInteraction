# MHCBI pipeline source


`MHCBI source` contains most scripts enabling the `MHCBI` performance. You can modify any script according to your needs. You can make a pull request using git if you consider that your changes can really improve the pipeline.

## Notepadding

Read all documentation available in the `docs` folder prior to keeping reading this specific information.

## Additional files

Two files that are not scripts at all: `listm.log` and `dftb_input.info`.

`listm.log` is the format that `MHCBI` uses for creating mutations from an initial PDB structure.
`dftb_input.info` is the file containing all necessary information for creating GAMESS input under FMO and DFTB3 methods.

The `dftb_infomaker.sh` script generates the `dftb_input.info` file for each running process. The `dftb_input.info` file in the source is a template about the specific information that will be in every GAMESS input file for FMO/DFTB3 calculations.

The `dowser.tcl` code file was taken from the original Dowser source code and `dowser_beta.tcl` source code is a modification originally coming from `dowser.tcl`.

## Advanced users

The MHCBI pipeline only facilitates one way for carrying out the whole methodology. Many conditions can be changed regarding user computational chemistry knowledge, (i.e. optimization parameters, quantum semiempirical mechanical method choice, implicit solvent conditions, fragmentation method, level of theory under FMO method, memory use ...).

The following scripts can thus be modified to change computing chemical conditions:

    1. dftb_infomaker.sh
    2. script_addH_tooptH.sh
    3. script_arc_auxmop.sh
    4. script_build_spmop
    5. script_ed_inp.sh
    6. script_editing_inputs.sh
    7. script_optH_to_optall.sh
    8. script_other_sp.sh
