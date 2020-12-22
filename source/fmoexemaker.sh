#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a script that runs FMO GAMESS inputs.

gamess_path="$1"

if [ -z "$gamess_path" ]
then
  echo "It lacks one or several arguments to execute this script"
  echo "For instance: ./fmoexemaker.sh path "
  exit 1
else
  echo "Creating a FMO script "
fi

echo "The absolute GAMESS path name is " $gamess_path

count=0
while [ $count -eq 0 ]
do
  read -p "Do you want to declare some options for GAMESS execution? type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ "$answer" == "yes" ] || [ "$answer" == "y" ]; then
    echo " *** "
    echo " "
    echo "Options depends on your GAMESS customization level (read that in your own GAMESS installation). A standard option could be: 00 8"
    echo "where 00 is the installed GAMESS version number and 8 the cpu cores number"
    echo " "
    read -p "Enter options for your GAMESS running: " options
    count=1
  elif [ "$answer" == "no" ] || [ "$answer" == "n" ]; then
    options=""
    echo " "
    echo "GAMESS will run without user options (it will use default options according its rungms)"
    count=1
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

cat << EOF > exec_fmo.sh
#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This script creates another script regarding GAMESS path and options.


EOF

printf "RUNGMS=\"$gamess_path\"\n\n" >> exec_fmo.sh
printf "for i in \`ls *.inp\`\n" >> exec_fmo.sh
printf "do\n" >> exec_fmo.sh
printf "  j=\"\$(echo \"\$i\" | cut -d'.' -f1)\".log\n" >> exec_fmo.sh
printf "  \$RUNGMS \$i $options > \$j\n" >> exec_fmo.sh
printf "done" >> exec_fmo.sh

echo " "
echo " exec_fmo.sh has been created"
echo " "
