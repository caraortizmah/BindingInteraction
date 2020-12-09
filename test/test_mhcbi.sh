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
  read -p "If you really fulfil the requirements type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " *** "
    echo " "
    count=1
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo "Please make sure that you have installed all of required programs prior to run the test"
    echo " bye..."
    exit 1;
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done
