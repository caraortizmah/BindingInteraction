#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
# Getting external program paths from pro_paths.log
#*************************************

FILE2=pro_paths.log

#external programs
if [ -f "$FILE2" ]; then

  #MOPAC path
  let cond=`grep -c "MOPAC path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    MOPAC_PATH=$(grep "MOPAC path" pro_paths.log | cut -d':' -f2) # After this cut.. there is a non-empty string assigned in this variable
    if [[ -z "${MOPAC_PATH// }" ]] ; then # This ( ${param //} ) expands the param variable and replaces all matches of the pattern (a single space) with nothing
      echo "MOPAC path is empty"
    else
            MOPAC_PATH=$(echo "$MOPAC_PATH" | awk '$1=$1') #remove blank spaces (head & tail)
      echo "MOPAC_path finished" $MOPAC_PATH
    fi
  else
    echo "MOPAC path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all program paths again"
  fi

  #Propka 3.1 path
  let cond=`grep -c "Propka 3.1 path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    PKA_PATH=$(grep "Propka 3.1 path" pro_paths.log | cut -d':' -f2)
    if [[ -z "${PKA_PATH// }" ]] ; then
      echo "Work directory is empty"
    else
            PKA_PATH=$(echo "$PKA_PATH" | awk '$1=$1')
      echo "PKA_path finished" $PKA_PATH
    fi
  else
    echo "Propka 3.1 path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all paths again"
  fi

  #VMD path
  let cond=`grep -c "VMD path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    VMD_PATH=$(grep "VMD path" pro_paths.log | cut -d':' -f2)
    if [[ -z "${VMD_PATH// }" ]] ; then
      echo "VMD structure path is empty"
    else
            VMD_PATH=$(echo "$VMD_PATH" | awk '$1=$1')
      echo "VMD_path finished" $VMD_PATH
    fi
  else
    echo "VMD path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all paths again"
  fi

  #GAMESS path
  let cond=`grep -c "GAMESS path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    GAMESS_PATH=$(grep "GAMESS path" pro_paths.log | cut -d':' -f2)
    if [[ -z "${GAMESS_PATH// }" ]] ; then
      echo "gamess path is empty"
    else
            GAMESS_PATH=$(echo "$GAMESS_PATH" | awk '$1=$1')
      echo "GAMESS_PATH finished" $GAMESS_PATH
    fi
  else
    echo "gamess path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all paths again"
  fi

  #OpenBabel path
  let cond=`grep -c "Babel path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    BABEL_PATH=$(grep "Babel path" pro_paths.log | cut -d':' -f2)
    if [[ -z "${BABEL_PATH// }" ]] ; then
      echo "OpenBabel path is empty"
    else
            BABEL_PATH=$(echo "$BABEL_PATH" | awk '$1=$1')
      echo "BABEL_PATH finished" $BABEL_PATH
    fi
  else
    echo "openbabel path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all paths again"
  fi

  #Chimera path
  let cond=`grep -c "Chimera path" pro_paths.log`
  if [ ${cond} -eq 1 ]; then
    CHIMERA_PATH=$(grep "Chimera path" pro_paths.log | cut -d':' -f2)
    if [[ -z "${CHIMERA_PATH// }" ]] ; then
      echo "Chimera path is empty"
    else
            CHIMERA_PATH=$(echo "$CHIMERA_PATH" | awk '$1=$1')
      echo "CHIMERA_PATH finished" $CHIMERA_PATH
    fi
  else
    echo "Chimera path was not detected"
    echo "Something in pro_paths.log would be wrong. Set all paths again"
  fi

  cd ${WORK_PATH}/${WORK_NAME}/ #locating pro_paths.out in the same place to paths.out

  cat << EOF > pro_paths.out
***Program path List***
***Do not change any word in this file***
1 :$MOPAC_PATH
2 :$PKA_PATH
3 :$VMD_PATH
4 :$GAMESS_PATH
5 :$BABEL_PATH
6 :$CHIMERA_PATH
***
EOF

else
  echo "Error: set the external program paths"
  echo "(execute setup.sh and select option 2)"
  exit 1
fi
