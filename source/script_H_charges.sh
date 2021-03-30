#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#@comment:
#This program builds a list with the name and number of residue and its required charge.
#It also modifies structures according to the step above.

#mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program - manual mode

MOPAC="$1"

if [ -z "$MOPAC" ]
then
  echo "It lacks one argument to execute the script"
  echo "For instance: ./script_H_charges.sh MOPAC path"
  exit 1
else
  echo "Running script... "
fi


mkdir -p final_pdbs
mkdir -p be_outputs
cd tobe_charged/

#fold="1kpv41_A19_6A/: 1kpv41_A19_8A/:" in case that you need to specify folders
#fold="1kpv4_A12_2A/:"
#for i in $fold #in each folder
for i in `ls */` #in each folder
do

  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
    nm="$(echo "$j" | cut -d'/' -f1)"
    res="$(echo "${i#*_}" | cut -d'/' -f1)"
    #res="$(echo "$j" | cut -d'/' -f1 | cut -d'_' -f2)" #receive the name of the folder next to the "_"
    cp "$nm".arc "$j"/
    cd "$j"

    cd ../../
    mkdir -p "$res"_charged
    cp tobe_charged/"$j"/aux_charges "$res"_charged/
    cp script_arc_auxmop.sh "$res"_charged/
    cp script_arc_to_pdb.sh "$res"_charged/
    cp script_arc_to_pdb_s.sh "$res"_charged/
    cp script_check_ch.sh "$res"_charged/
    cp script_let.sh "$res"_charged/
    cp script_build_spmop.sh "$res"_charged/
    cp script_other_sp.sh "$res"_charged/
    cp tobe_charged/"$j"/"$nm".arc "$res"_charged/
    cd "$res"_charged/

    #`cat aux_charges | awk NF==10'{print $0}' | wc -l`  --> total number of lines with charged residues information
    #BEGIN{...} assignation of data in arrays a and b
    #END{...} for ... this loop evaluates each 2 steps
    #END{...} if ... due to the conditional it is possible to compare each to lines (file_alternate_state.pka vs file.pka)
    #END{...} c[j] this vector has all filtered information over charged residues
    # |
    # v

    awk -v fin=`cat aux_charges | awk NF==10'{print $0}' | wc -l` '
        BEGIN{i=1; j=0} NF==10{a[i]=$7; b[i]=$0; i++}
        END{for (i=1;i<=fin;i=i+2) {
                j++;
                if (a[i]==a[i+1]){c[j]=b[i]}
                else if(a[i]==0){c[j]=b[i]}
                else if (a[i+1]==0){c[j]=b[i+1]}
                else{c[j]="It is a mistake"}
                printf "%s ---- \n",c[j] }}' aux_charges >> chosen_charges

    ./script_arc_auxmop.sh "$nm".arc "$res" neutral #new mopac input neutral done

    #set_val="$(echo -n `awk '$7<0{printf "%s%d(-),",$4,$3}; $7>0{printf "%s%d(+),",$4,$3}' chosen_charges` | head -c -1)"
    #echo " LET SITE=($set_val)" > new_input.mop
    ./script_let.sh "new_input.mop"
    #printf "\n\n" >> new_input.mop
    awk -v x="ATOM" '( NF==9 ) && ( $1 ~x ) {print $0}' Opt_"$res"_neutral.mop >> new_input.mop

    ${MOPAC} new_input.mop
    #$mopac16 new_input.mop # manual mode

    ./script_check_ch.sh new_input.out ${MOPAC}

    ./script_arc_auxmop.sh new_input.arc "$res" charged

    cp Opt_"$res"_neutral.mop comp1
    cp Opt_"$res"_charged.mop comp2
    #neutral as comp1 and charged as comp2

    # awk 'NR==FNR{c[$7]++;next};c[$7] == 0' comp1 comp2 > comp3    #--> comparison is just for a one column
    awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp1 comp2 > comp3
    awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp2 comp1 > comp4

    cp comp1 comp_final

    #well done!
    while read i; do echo "$i"; jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"; echo "$jj"; let jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"; echo "$jjj"; sed  -i "$jjj a $i" comp_final; done < <(awk '{print $0}' comp3) #add protons

    cp comp_final aux_comp_final

    while read i; do echo "$i"; sed "/$i/d" aux_comp_final > comp_final2; mv comp_final2 aux_comp_final; done < <(awk '{print $0}' comp4) #delete protons

    mv aux_comp_final comp_final2

    ./script_build_spmop.sh comp_final2

    ./script_other_sp.sh comp_final2

    mv comp_final2.mop comp_final_"$res".mop
    mv comp-pep_final2.mop comp-pep_final_"$res".mop
    mv pep_final2.mop pep_final_"$res".mop

    ${MOPAC} comp_final_"$res".mop #comp_final2.mop
    ${MOPAC} comp-pep_final_"$res".mop #comp-pep_final2.mop
    ${MOPAC} pep_final_"$res".mop #pep_final2.mop

    ./script_arc_to_pdb_s.sh comp_final_"$res".arc #comp_final2.arc
    ./script_arc_to_pdb_s.sh comp-pep_final_"$res".arc #comp-pep_final2.arc
    ./script_arc_to_pdb_s.sh pep_final_"$res".arc #pep_final2.arc

    mkdir -p complex_"$res"
    mkdir -p comp-pep_"$res"
    mkdir -p pep_"$res"

    mv comp_final_"$res".* complex_"$res"/
    cp complex_"$res"/comp_final_"$res".pdb ../final_pdbs/C_"$res".pdb
    cp complex_"$res"/comp_final_"$res".arc ../be_outputs/C_"$res".arc
    mv comp-pep_final_"$res".* comp-pep_"$res"/
    cp comp-pep_"$res"/comp-pep_final_"$res".pdb ../final_pdbs/R_"$res".pdb
    cp comp-pep_"$res"/comp-pep_final_"$res".arc ../be_outputs/R_"$res".arc
    mv pep_final_"$res".* pep_"$res"/
    cp pep_"$res"/pep_final_"$res".pdb ../final_pdbs/L_"$res".pdb
    cp pep_"$res"/pep_final_"$res".arc ../be_outputs/L_"$res".arc

    cd ../tobe_charged/

  fi
done

#echo "fin"
