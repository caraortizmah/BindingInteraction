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

mkdir -p workdir_test
cp ../paths.log .
cp ../pro_paths.log .
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

  cat << EOF > paths.out
***Path List***
***Do not change any word in this file***
1 :$MHCBI_PATH
2 :$MHCBI_PATH/test/
3 :example-3oxs.pdb
4 :$MHCBI_PATH/test/workdir_test/
5 :3oxr_test
***
EOF



  cd ${WORK_PATH}
  mkdir -p ${WORK_NAME}
  cd ${MHCBI_PATH}
  cp -r source/ ${WORK_PATH}/${WORK_NAME}
  cd ${WORK_PATH}/${WORK_NAME}/
  cp ${PDB_PATH}/${PDB_NAME} .
  mkdir -p optimizations
  mkdir -p mutations
  mkdir -p calculations

else
  echo "First of all set the list of directories"
  echo "(execute setup.sh and select option 1)"
  exit 1
fi

chmod +x conf.sh
./conf.sh

