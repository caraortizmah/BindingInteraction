#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

FILE=paths.out

if [ -f "$FILE" ]; then
  WORK_PATH=$(grep "4 " ${FILE} | cut -d':' -f2)
  WORK_NAME=$(grep "5 " ${FILE} | cut -d':' -f2)
else
  echo "paths.out doesn't exist"
  echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
  exit 1
fi

let input=0

while [ $input -ne 3 ]; 2> /dev/null
do
  echo "**** The MHCBI Pipeline ****"
  echo "Please select your option"
  echo "1 Run MHCBI in a single step"
  echo "2 Run MHCBI step by step"
  echo "3 End running pipeline"
  echo " "
  echo " "
  read input
  case $input in
    1)
      echo "***Running MHCBI in a single step***"
      echo " "
      cd ${WORK_PATH}/WORK_NAME/
      cp source/run_mhcbi.sh .
      chmod +x run_mhcbi.sh
      ./run_mhcbi.sh
      echo "...going to the menu..."
      rm -f run_mhcbi.sh
      ;;
    2)
      echo "***Assigning external program paths***"
      echo " "
      cd ${WORK_PATH}/WORK_NAME/
      cp source/run_mhcbi_step.sh .
      chmod +x run_mhcbi_step.sh
      ./run_mhcbi_step.sh
      echo "...going to the menu..."
      rm -f run_mhcbi_step.sh
      ;;
    3)
      echo "  Closing pipeline... bye "
      exit 1
      ;;
    *)
      #clear
      echo "Sorry, you need to choose an option among 1 up to 3"
      ;;
    ''|*[!0-9]*)
      #clear
      echo "Sorry, you need to choose a numerical option"
      let input=0
      ;;
  esac
done
