# MHCBI pipeline source


`MHCBI source` contains the mayority of scripts that make possible the `MHCBI` performance. You can modify any script according your necessities. You can do a pull request through git if you consider that your changes are important for improving the pipeline.

## Additional files

There two files that are not scripts at all: `listm.log` and `dftb_input.info`.

`listm.log` is the format that `MHCBI` uses for creating mutations from initial PDB structure.
`dftb_input.info` is the file that contains all necessary information for creating an GAMESS input under FMO and DFTB3 methods.

## Advance user

MHCBI pipeline only enables one way for performing all the methodology. There a huge amount of conditions that you can change regarding your computational chemistry knowledge, (i.e. optimization parameters, semiempirical method choice, implicit solvent conditions, fragmentation method, level of theory under FMO method, memory use amount...).
So, you can modify the following scripts aiming to change computing chemical conditions:

    1. dftb_infomaker.sh
    2. script_addH_tooptH.sh
    3. script_arc_auxmop.sh
    4. script_build_spmop
    5. script_ed_inp.sh
    6. script_editing_inputs.sh
    7. script_optH_to_optall.sh
    8. script_other_sp.sh

