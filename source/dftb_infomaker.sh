#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a DFTB format for FMO GAMESS input using DFTB3 parameters.

dir="$1"

if [ -z "$dir" ]
then
  echo "It lacks one or several arguments to execute this script"
  echo "For instance: ./dftb_infomaker.sh and parameters_path"
  exit 1
else
  echo "Creating a chimera script "
fi


cat << EOF > dftb_input.info
 $CONTRL RUNTYP=ENERGY NPRINT=-5 ISPHER=-1 MAXIT=50 $END
 $GDDI   NGROUP=1 PAROUT=.T. BALTYP=NXTVAL $END
 $SYSTEM MWORDS=700 $END
 $BASIS  GBASIS=DFTB $END
 $PCM    SOLVNT=WATER IEF=-10 ICOMP=0
         ICAV=1 IDISP=1 IFMO=-1 $END
 $PCMCAV RADII=SUAHF $END
 $TESCAV NTSALL=60 $END
 $DFTB
   SCC=.TRUE.
   DAMPXH=.TRUE.
   DAMPEX=4.00
   DFTB3=.TRUE.
   DISP=UFF
 $END
 $FMOPRP
    NPRINT=138
 $END
 $DFTBSK
   C C "${dir}/param_DFTB3/3ob-3-1/C-C.skf"
   C H "${dir}/param_DFTB3/3ob-3-1/C-H.skf"
   C O "${dir}/param_DFTB3/3ob-3-1/C-O.skf"
   C N "${dir}/param_DFTB3/3ob-3-1/C-N.skf"
   H C "${dir}/param_DFTB3/3ob-3-1/H-C.skf"
   H H "${dir}/param_DFTB3/3ob-3-1/H-H.skf"
   H O "${dir}/param_DFTB3/3ob-3-1/H-O.skf"
   H N "${dir}/param_DFTB3/3ob-3-1/H-N.skf"
   O C "${dir}/param_DFTB3/3ob-3-1/O-C.skf"
   O H "${dir}/param_DFTB3/3ob-3-1/O-H.skf"
   O O "${dir}/param_DFTB3/3ob-3-1/O-O.skf"
   O N "${dir}/param_DFTB3/3ob-3-1/O-N.skf"
   N C "${dir}/param_DFTB3/3ob-3-1/N-C.skf"
   N H "${dir}/param_DFTB3/3ob-3-1/N-H.skf"
   N O "${dir}/param_DFTB3/3ob-3-1/N-O.skf"
   N N "${dir}/param_DFTB3/3ob-3-1/N-N.skf"
   S S "${dir}/param_DFTB3/3ob-3-1/S-S.skf"
   S C "${dir}/param_DFTB3/3ob-3-1/S-C.skf"
   S H "${dir}/param_DFTB3/3ob-3-1/S-H.skf"
   S O "${dir}/param_DFTB3/3ob-3-1/S-O.skf"
   S N "${dir}/param_DFTB3/3ob-3-1/S-N.skf"
   C S "${dir}/param_DFTB3/3ob-3-1/C-S.skf"
   H S "${dir}/param_DFTB3/3ob-3-1/H-S.skf"
   O S "${dir}/param_DFTB3/3ob-3-1/O-S.skf"
   N S "${dir}/param_DFTB3/3ob-3-1/N-S.skf"
 $END
 $FMO
      MODMUL=0
      NLAYER=1
--
 HOP_C        4   4
1 0  0.562  0.000  0.000  0.827
0 1  0.562  0.779  0.000 -0.275
0 1  0.562 -0.389  0.675 -0.275
0 1  0.562 -0.389 -0.675 -0.275
--
 C   6
 O   8
 H   1
 N   7
 S   16

EOF
