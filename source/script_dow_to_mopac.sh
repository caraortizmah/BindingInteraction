#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#comment:
#This program changes a dowser output file into a pdb file available in mopac


arg="$1"
BABEL="$2"

if [ -z "$arg" ]  || [ -z "$BABEL" ] #execution of this program waits an additional argument
then
  echo "It lacks one argument to execute the script"
  echo "For instance: ./script_dow_to_mopac.sh dowser_file.pdb and babel path"
  exit 1
else
  echo "Executing script_dow_to_mopac.sh over "$arg #This argument is an output pdb file from dowser execution
fi

version_babel=$(${BABEL} -V)
ver_babel=$(echo "$version_babel" | awk '{print $3}' | cut -d'.' -f1)

if [ "$ver_babel" -ge "3" ]; then #if babel version is greater or equal to 3...

  ${BABEL} "$arg" -O aux_step.pdb -d #Call babel to delete hydrogens in pdb file
  #babel "$arg" -O aux_step.pdb -d #Call babel to delete hydrogens in pdb file - manual mode

else

  ${BABEL} -d -ipdb "$arg" -opdb aux_step.pdb #Call babel to delete hydrogens in pdb file
  #babel -d -ipdb "$arg" -opdb aux_step.pdb #Call babel to delete hydrogens in pdb file - manual mode

fi

sed -i 's/TRE/HOH/g' aux_step.pdb #Replace all words "TRE" by "HOH"
sed -i 's/OW/O /g' aux_step.pdb #Replace all words "OW" by "O"
sed -i 's/HETATM/ATOM   /g' aux_step.pdb #Replace all words "HETATM" by "ATOM"

awk 'BEGIN{i=1; j=1} NF=="12"{if ($3 =="H1" || $3 =="H2") {j++; i++;} else {printf "%s%7d  %-3s %3s %s%4d%12.3f%8.3f%8.3f  %3.2f  %3.2f%12s\n",$1,j++,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}}' aux_step.pdb > aux_step1.pdb #Fix format and renumber atoms

awk 'BEGIN{i=1} NF=="12"{if ($5=="W") printf "%s%7d  %-3s %3s %s%4d%12.3f%8.3f%8.3f  %3.2f  %3.2f%12s\n",$1,$2,$3,$4,$5,i++,$7,$8,$9,$10,$11,$12; else printf "%s%7d  %-3s %3s %s%4d%12.3f%8.3f%8.3f  %3.2f  %3.2f%12s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux_step1.pdb > aux_step2.pdb #Fix format and renumber atoms

if [ "$ver_babel" -ge "3" ]; then #if babel version is greater or equal to 3...

  ${BABEL} aux_step2.pdb -O pdbformopac_"$arg" -h #Call babel to add hidrogens in pdb file
  #babel aux_step2.pdb -O pdbformopac_"$arg" -h #manual mode

else

  ${BABEL} -h -ipdb aux_step2.pdb -opdb pdbformopac_"$arg" #Call babel to add hidrogens in pdb file
  #babel -h -ipdb aux_step2.pdb -opdb pdbformopac_"$arg" #Call babel to add hidrogens in pdb file - manual mode

fi

rm -f aux_step.pdb aux_step2.pdb #Delete auxiliary files

