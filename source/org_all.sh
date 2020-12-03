#!/bin/bash

arg="$1"
#main_name="$2"
dir_pdb="$2"
name_pdb="$3"
work_dir="$4"

name_f="$(echo "$name_pdb" | cut -d'.' -f1)"

./part1.sh $arg $dir_pdb $name_pdb $work_dir > $name_f.log
./part2.sh $arg $name_pdb $work_dir >> $name_f.log # $dir_pdb $name_pdb $work_dir >> $name_f.log
./part3.sh $arg $name_pdb $work_dir >> $name_f.log # $dir_pdb $name_pdb $work_dir >> $name_f.log
