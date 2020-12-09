#!/bin/bash

ARG="$1"
DIR_PDB="$2"
NAME_PDB="$3"
WORK_DIR="$4"

VMD="$5"
BABEL="$6"
MOPAC="$7"

name_f="$(echo "$NAME_PDB" | cut -d'.' -f1)"

./part1.sh $ARG $DIR_PDB $NAME_PDB $WORK_DIR $VMD $BABEL > $name_f.log
./part2.sh $ARG $NAME_PDB $WORK_DIR $MOPAC >> $name_f.log # $DIR_PDB $NAME_PDB $WORK_DIR >> $name_f.log
./part3.sh $ARG $NAME_PDB $WORK_DIR $MOPAC >> $name_f.log # $DIR_PDB $NAME_PDB $WORK_DIR >> $name_f.log
