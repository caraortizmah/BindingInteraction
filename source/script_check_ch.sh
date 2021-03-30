#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#@comment:
#Selecting information about the charged residues that will be changed (adding or deleting H)

#mopac16="/opt/mopac/MOPAC2016.exe" - manual mode

arg="$1"
MOPAC="$2"

if [ -z "$arg" ] || [ -z "$MOPAC" ]
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./script_check_ch.sh output_mopac_file and MOPAC path"
  exit 1
else
  echo "Executing script_check_ch.sh over "$arg #they need also the input (.mop file)
fi


if grep -q "Error and normal termination" "$arg" && grep -q "Site:" "$arg"
then
    num=$(grep -n "Error and normal termination messages" "$arg" | cut -d':' -f1)
    res="$(awk -v x=$num -v y="(-)" 'NR>=x && $2=="Site:" && $4 ~ y {printf "%s\n",$4}' "$arg" | cut -d"'" -f2 | cut -d'(' -f1)"
    mop="$(echo $arg | cut -d'.' -f1)".mop

    for i in $res
    do
      rnum=$(echo $i | sed "s/[[:alpha:].-]//g") #only returing the numeric part
      chain="$(echo $i | sed "s/[0-9]*//g")" #only returing the string
      rrnum=$rnum
      rnum=$rnum")"

      mv "$mop" aux
      mv chosen_charges aux-chosen_charges
      awk -v x=$rrnum -v y=$chain '!($4==y && $3==x) {print $0}' aux-chosen_charges > chosen_charges

      ./script_let.sh $mop
      #awk 'NR==1 {printf "%s\n\n\n",$0}' "$mop" > aux

      awk -v x=$rnum -v y=$chain 'BEGIN{i=1} NF=="9" {if ( $6==x && $5==y ){ if ($3!="HE1" && $3!="HE2" && $3!="HD1" && $3!="HD2") {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,6),$4,$5,$6,$7,$8,$9}} else {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,6),$4,$5,$6,$7,$8,$9} }' aux >> "$mop"

    done

    ${MOPAC} $mop
    #$mopac16 $mop #manual mode
    #echo "fin"

else

    echo "There is not any problem adding or removing H according on propka3.1"

fi
