#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the installation pipeline through Shell Script.
#*************************************

echo "**********Installation**********"
echo "Your current installation directory is "$PWD
echo " "

while :
do
  read -p "Do you want to use it as MHCBI path name? (Yes(Y/y)/No(N/n)) " answer
  answer=${answer,,}

  if [ -z "${answer}" ]; then
  	echo "Empty answer, please enter again your answer - yes (y) or no (n)"
  elif [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " "
    pipeline_path=$PWD
    break
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo " "
    read -p "Enter the MHCBI path name : " pipeline_path
    break
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

if [ "$pipeline_path" != "$PWD" ]; then

	git=$PWD
	echo "***Creating folders..."
	mkdir -p $pipeline_path
	cd $pipeline_path
	mkdir -p MHCBI
	cd MHCBI
  rm -f MHCBI_uninstalled.readme
  cp $git/README.md .
	cp $git/BindingInteraction/setup.sh .
  cp $git/BindingInteraction/paths.sh .
	cp $git/BindingInteraction/pro_paths.sh .
	cp $git/BindingInteraction/conf.sh .
  cp $git/BindingInteraction/pre-run.sh .
	cp $git/BindingInteraction/uninstall.sh .
	chmod +x *.sh
	cp -r $git/source .
	cp -r $git/test .
	#cp source/pre-run.sh .
	#cp source/organizer.sh .
	echo "Go to the new directory"
	echo "Type cd "$pipeline_path"/MHCBI/"

else

  echo "***No additional operations were needed..."
  rm -f MHCBI_uninstalled.readme
  cd BindingInteraction/
  mv -f setup.sh ../
  mv -f paths.sh ../
  mv -f pro_paths.sh ../
  mv -f conf.sh ../
  mv -f pre-run.sh ../
  mv -f uninstall.sh ../
  cd ../
  chmod +x *.sh
  #cp source/pre-run.sh .
	echo "Stay in the same directory: "$PWD

fi
