#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

FILE=paths.out
FILE2=pro_paths.out

if [ -f "$FILE" ]; then
	MHCBI_PATH=$(grep "1 " ${FILE} | cut -d':' -f2)
	PDB_PATH=$(grep "2 " ${FILE} | cut -d':' -f2)
	PDB_NAME=$(grep "3 " ${FILE} | cut -d':' -f2)
	WORK_PATH=$(grep "4 " ${FILE} | cut -d':' -f2)
	WORK_NAME=$(grep "5 " ${FILE} | cut -d':' -f2)
else
	echo "paths.out doesn't exist"
	echo "Configure the MHCBI pipeline executing setup.sh and select option 3)"
	exit 1
fi

if [ -f "$FILE2" ]; then
  MOPAC_PATH=$(grep "1 " ${FILE2} | cut -d':' -f2)
  PKA_PATH=$(grep "2 " ${FILE2} | cut -d':' -f2)
  VMD_PATH=$(grep "3 " ${FILE2} | cut -d':' -f2)
  GAMESS_PATH=$(grep "4 " ${FILE2} | cut -d':' -f2)
  BABEL_PATH=$(grep "5 " ${FILE2} | cut -d':' -f2)
  CHIMERA_PATH=$(grep "6 " ${FILE2} | cut -d':' -f2)
else
  echo "pro_paths.out doesn't exist"
  echo "Configure the MHCBI pipeline executing setup.sh and select option 3)"
  exit 1
fi

let input=0

while [ $input -ne 4 ]; 2> /dev/null
do
  echo "**** The MHCBI Pipeline FMO calculations****"
  echo "Please select your option"
  echo "1. Configure FMO folders"
  echo "2. Select running GAMESS options"
  echo "3. Run MHCBI FMO"
  echo "4. End running pipeline"
  echo " "
  echo " "
  read input
  case $input in
    1)
      echo "***Configuring folders for FMO calculations***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/
      cp source/org_fmocalc.sh .
      chmod +x org_fmocalc.sh
      ./org_fmocalc.sh
      echo "...going to the menu..."
      rm -f org_fmocalc.sh
      ;;
    2)
      echo "***Selecting GAMESS execution options***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/

      echo "The absolute GAMESS path name is " $GAMESS_PATH

      count=0
      while [ $count -eq 0 ]
      do
        read -p "Do you want to declare some options for GAMESS execution? type (Yes(Y/y), otherwise (No(N/n)): " answer
        answer=${answer,,}

        if [ $answer == "yes" ] || [ $answer == "y" ]; then
          echo " *** "
          echo " "
          echo "options depends on your GAMESS customization level (read your own GAMESS installation), a standard options could be:"
          echo "00 48: 00 is the version number and 48 the cpu cores number"
          echo " "
          read -p "Enter options for your GAMESS running: " gamess_opt
          count=1
        elif [ $answer == "no" ] || [ $answer == "n" ]; then
          gamess_opt=""
          echo " "
          echo "GAMESS will run by default options"
          count=1
        else
          echo "Please enter again your answer - yes (y) or no (n)"
        fi

      done

      cat << EOF > exec_fmo.sh
#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

EOF
      printf "RUNGMS=\"$GAMESS_PATH\"\n\n" >> exec_fmo.sh
      printf "for i in \`ls *.inp\`\n" >> exec_fmo.sh
      printf "do\n" >> exec_fmo.sh
      printf "  j=\"\$(echo \"\$i\" | cut -d'.' -f1)\".log\n" >> exec_fmo.sh
      printf "  \$RUNGMS \$i $gamess_opt > \$j\n" >> exec_fmo.sh
      printf "done" >> exec_fmo.sh

      echo " "
      echo "...going to the menu..."
      ;;
    3)
      echo "***Running input GAMESS***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/
      cp source/run_mhcbifmo.sh .
      mv exec_fmo.sh fmo-calculations/fmo_molecules/
      chmod +x run_mhcbifmo.sh
      ./run_mhcbifmo.sh
      echo " "
      echo "...going to the menu..."
      rm -f run_mhcbifmo.sh
      ;;
    4)
      echo "  Closing pipeline... bye "
      exit 1
      ;;
    *)
      #clear
      echo "Sorry, you need to choose an option among 1 up to 4"
      ;;
    ''|*[!0-9]*)
      #clear
      echo "Sorry, you need to choose a numerical option"
      let input=0
      ;;
  esac
done

cd ${WORK_PATH}/${WORK_NAME}

echo "****** MHCBI says: ******"
echo "  All folders and scripts were organized"
