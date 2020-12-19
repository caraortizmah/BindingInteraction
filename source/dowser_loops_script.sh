#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

arg="$1"
VMD="$2"
BABEL="$3"


let iter=1
clause=true
let var_3=0
#shift
#for i in "$@" ; do
#	arg="${arg} '$i'"
#done

if [ -z "$arg" ]
then
  echo "It lacks pdb file to execute the script"
  echo "For instance: ./dowser_loops_script.sh file.pdb"
  exit 1
else
  echo "Executing dowser_loops_script.sh over "$arg
fi

while $clause
do

  k=""

  mkdir "$iter"_iter
  if [ $iter -eq 1 ]
  then
    cp "$arg" molecule.pdb
  else
    cp $((iter-1))_iter/step_$((iter-1)).pdb molecule.pdb
  fi

  mv molecule.pdb "$iter"_iter/
  cp folder_1/* "$iter"_iter/
  cd "$iter"_iter/

  if [ $iter -eq 1 ]
  then
    ${VMD} -dispdev text -e prepare_st2.tcl > output_"$iter".log
    # vmd -dispdev text -e prepare_st2.tcl > output_"$iter".log #manual mode
  else
    ${VMD} -dispdev text -e prepare_st2.tcl > output_"$iter".log
    #vmd -dispdev text -e prepare_st2.tcl > output_"$iter".log #manual mode
  fi

  #if [ $iter -eq 1 ]
  #then
  #  ${VMD} -dispdev text -e prepare_st2.tcl > output_"$iter".log
  #  vmd -dispdev text -e prepare_st2.tcl > output_"$iter".log #manual mode
  #else
  #  ${VMD} -dispdev text -e prepare_st1.tcl > output_"$iter".log
  #  vmd -dispdev text -e prepare_st1.tcl > output_"$iter".log #manual mode
  #fi

  #${VMD} -dispdev text -e prepare_st.tcl > output_"$iter".log
  #vmd -dispdev text -e prepare_st.tcl > output_"$iter".log #manual mode

  #${BABEL} -j -ipdb processed-for-dowser.pdb -ipdb placed_waters_1.pdb ... -ipdb placed_waters_n.pdb -opdb step"$iter".pdb
  #babel -j -ipdb processed-for-dowser.pdb -ipdb placed_waters_1.pdb ... -ipdb placed_waters_n.pdb -opdb step"$iter".pdb #manual mode

  for i in `ls placed_waters_* 2>/dev/null` #suppressing error message if placed_waters is not found at the beginning of dowser operation
  do
    if [ $(wc -l "$i" | awk '{print $1}') -gt 1 ]
    then
      k=$k" -ipdb "$i
    fi
  done

  ${BABEL} -j ${k} -opdb temporary_wat.pdb

  if [ ! -s "temporary_wat.pdb" ]; then #if it is empty...
    cp processed-for-dowser.pdb step_"$iter".pdb
  else
    ${BABEL} -j -ipdb processed-for-dowser.pdb ${k} -opdb step_"$iter".pdb
    #babel -j -ipdb processed-for-dowser.pdb $k -opdb step_"$iter".pdb #manual mode

    #IN THE FUTURE:
    #obabel processed-for-dowser.pdb placed_waters_1.pdb placed_waters_2.pdb placed_waters_3.pdb -O step_"$iter".pdb -j

  fi

  for var_1 in $(grep -n "DRAIN AWAY EXTERNAL DOWSER WATERS" output_"$iter".log | cut -d ":" -f1 | tail -2)
  do
    let var_1=$var_1+2
    let var_2=$(sed -n "$var_1"p output_"$iter".log | awk '{print $4}')
    let var_3=$var_2+$var_3
  done

  if grep -q "No water molecules in the input of " output_"$iter".log
  then
    let var_4=0
  else
    var_4=$(grep -n "remaining water molecules" output_"$iter".log | tail -1 | awk '{print $4}')
  fi

  if  [ $var_3 -le 2 ]
  then
    echo "Dowser puts 2 or less waters. It might not put more waters later"
  else
    echo "Dowser puts $var_3 waters. It'll put more waters later"
  fi

  if  [ "$var_4" -le 1 ]
  then
    echo "Dowserx puts 1 or less waters. It might not put more waters later"
  else
    echo "Dowserx puts $var_4 waters. It'll put more waters later"
  fi

  if [ $var_3 -lt 3 ] #&& [ $var_4 -lt 2 ]
  then
    clause=false
  else
    clause=true
  fi

  #let clause=$clause+3
  let iter=$iter+1
  let var_3=0

  cd ..

done

let iter=$iter-1
cp "$iter"_iter/step_"$iter".pdb final_step.pdb

echo "$arg"
