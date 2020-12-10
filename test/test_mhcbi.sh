#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

echo "****Warning****"
echo "Make sure that you have already installed the following linux text processing tools: "
echo "  1. Grep"
echo "  2. Cut"
echo "  3. Awk"
echo "  4. Sed"
echo "and the following specialized softwares such as: "
echo "  5. Open Babel"
echo "  6. VMD - Visual Molecular Dynamics"
echo "  7. MOPAC - Molecular Orbital PACkage"
echo "  8. UCSF Chimera"
echo "  9. PROPKA 3.1"
echo " 10. GAMESS - General Atomic and Molecular Electronic Structure System"
echo " 11. python 2.7 or higher"
echo "****Warning****"
echo "  "

count=0
while [ $count -eq 0 ]
do
  read -p "Do you complete until third step when executing ./setup.sh? If you really fulfil the requirements type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " *** "
    echo " "
    count=1
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo "Please make sure that you have installed all of required programs prior to run the test and that you configure MHCBI pipeline until 3rd step"
    echo " bye..."
    exit 1;
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

#cleaning previous test

echo "cleaning previous test"
rm *.out
rm *.log
rm conf.sh
rm -rf workdir_test


mkdir -p workdir_test
cp ../paths.log .
cp ../conf.sh .

FILE=paths.log

#work directory
if [ -f "$FILE" ]; then

  #Main path
  let cond=`grep -c "MHCBI path" paths.log`
  if [ ${cond} -eq 1 ]; then
    MHCBI_PATH=$(grep "MHCBI path" paths.log | cut -d':' -f2) # After this cut.. there is a non-empty string assigned in this variable
    if [[ -z "${MHCBI_PATH// }" ]] ; then # This ( ${param //} ) expands the param variable and replaces all matches of the pattern (a single space) with nothing
      echo "Pipeline path is empty"
    else
            MHCBI_PATH=$(echo "$MHCBI_PATH" | awk '$1=$1') #remove blank spaces (head & tail)
      echo "mhcbi_path finished" $MHCBI_PATH
    fi
  else
    echo "Pipeline path was not detected"
    echo "Something in paths.log would be wrong. Set all paths again"
  fi

  #Work directory
  let cond=`grep -c "Work path" paths.log`
  if [ ${cond} -eq 1 ]; then
    WORK_PATH=$(grep "Work path" paths.log | cut -d':' -f2)
    if [[ -z "${WORK_PATH// }" ]] ; then
      echo "Work directory is empty"
    else
            WORK_PATH=$(echo "$WORK_PATH" | awk '$1=$1')
      echo "work_path finished" $WORK_PATH
    fi
  else
    echo "Work directory was not detected"
    echo "Something in paths.log would be wrong. Set all paths again"
  fi

  #PDB name
  let cond=`grep -c "PDB name" paths.log`
  if [ ${cond} -eq 1 ]; then
    PDB_NAME=$(grep "PDB name" paths.log | cut -d':' -f2)
    if [[ -z "${PDB_NAME// }" ]] ; then
      echo "PDB structure name is empty"
    else
            PDB_NAME=$(echo "$PDB_NAME" | awk '$1=$1')
      echo "pdb_name finished" $PDB_NAME
    fi
  else
    echo "PDB structure name was not detected"
    echo "Something in paths.log would be wrong. Set all paths again"
  fi

  #Work name
  let cond=`grep -c "Work name" paths.log`
  if [ ${cond} -eq 1 ]; then
    WORK_NAME=$(grep "Work name" paths.log | cut -d':' -f2)
    if [[ -z "${WORK_NAME// }" ]] ; then
      echo "To-do work name is empty"
      echo "Work name will be assigned as pdb structure name"
      WORK_NAME=$(echo "$PDB_NAME" | cut -d'.' -f1)
      echo "work_name finished" $WORK_NAME
    else
      echo "work_name finished" $WORK_NAME
    fi
    WORK_NAME=$(echo "$WORK_NAME" | awk '$1=$1')
  else
    echo "To-do work name was not detected"
    echo "Work name will be assigned as pdb structure name"
    WORK_NAME=$(echo "$PDB_NAME" | cut -d'.' -f1)
    echo "work_name finished" $WORK_NAME
    WORK_NAME=$(echo "$WORK_NAME" | awk '$1=$1')
  fi

  cp ${WORK_PATH}/${WORK_NAME}/pro_paths.out . #variables needed to get pro_paths.out

  #change of paths for test
  PDB_PATH=$(echo "${MHCBI_PATH}/test/")
  PDB_NAME="example-3oxs.pdb"
  WORK_PATH=$(echo "${MHCBI_PATH}/test/workdir_test")
  WORK_NAME="3oxs_test"


  cat << EOF > paths.out
***Path List***
***Do not change any word in this file***
1 :$MHCBI_PATH
2 :$PDB_PATH
3 :$PDB_NAME
4 :$WORK_PATH
5 :$WORK_NAME
***
EOF

  cd ${WORK_PATH}
  mkdir -p ${WORK_NAME}
  cd ${MHCBI_PATH}
  cp -r source/ ${WORK_PATH}/${WORK_NAME}
  cd ${WORK_PATH}/${WORK_NAME}/source/
  chmod +x *.sh #giving permissions
  chmod +x *.tcl
  cd ../
  cp ${PDB_PATH}/${PDB_NAME} .
  cp ../../paths.out .
  cp ../../pro_paths.out .
  mkdir -p optimizations
  mkdir -p mutations
  mkdir -p calculations

  cd ${WORK_PATH}/${WORK_NAME}/
  cp source/organizer.sh .
  cp source/run_mhcbi.sh .
  echo "**** Bear in mind: "
  echo "Run the pipeline typing ./run.sh in this path: " ${WORK_PATH}/${WORK_NAME}/
  echo "*** "
  echo "    "

  ./organizer.sh
  ./run_mhcbi.sh

else
  echo "First of all set the list of directories"
  echo "(execute setup.sh and select option 1)"
  exit 1
fi
