#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the uninstall script.
#*************************************

echo "**********Removing program**********"
echo "Your current installation directory is "$PWD
echo " "

rem=false

while :
do
  read -p "Do you want to uninstall the MHCBI pipeline? (Yes(Y/y)/No(N/n)) " answer
  answer=${answer,,}

  if [ -z "${answer}" ]; then
  	echo "Empty answer, please enter again your answer - yes (y) or no (n)"
  elif [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " "
    rem=true
    break
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo " "
    read -p "Enter the MHCBI path name : " pipeline_path
    break
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

if [ "$rem" == "true" ]; then

	echo "***Removing folders..."
  rm -rf source
  rm -rf test
  echo "***Removing manager scripts..."
  rm -rf *.sh
  rm -rf *.out
  rm -rf *.log

cat << EOF > MHCBI_uninstalled.readme
====================================
|*** MHCBI says:                   |
|Thanks for using the pipeline!    |
|    hope to see you soon          |
====================================
For further information go to:
https://github.com/caraortizmah/BindingInteraction
***
EOF

fi
