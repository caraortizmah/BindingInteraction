#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

  #awk 'BEGIN{i=1} NF=="5"{printf "%1d%5s%4s%2s%9d%11d \n",i++,$1,$2,$3,$4,$5}' aux2.pdb > 1BX2_"$name".pdb
  
#for i in `ls */` #in each folder
#do
#
#  j="$(echo "$i" | cut -d':' -f1)"
#  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
#    echo "$j"
#    cd "$j"
#
#    #echo "residues with charges" > aux_charges
#    for ii in `ls */`
#    do
#      jj="$(echo "$ii" | cut -d':' -f1)"
#      if [ -d "$jj" ] && [ "$(echo "$jj" | cut -d'_' -f1)" == "opt" ]; then  # directory exists or not and if the name starts with "opt" 
#        echo "$jj"
#        cd "$jj"
#        cp ../../residues_charges . #residues_charges contains all information about what the charged residues are
#        echo "residues with charges" > aux_charges
#        #this file will host information of charges of some residues for each mutation taking into account residues_charges file
#        echo "       Group       pKa      model-pKa     charge" >> aux_charges 
#
#        let i=0
#        while read line #line variable has been written at the end of the while sentence
#	do
#          let i+=1
#          #echo "$line"
#        
#          for input in `ls *.pka` #look up the two available .pka files --> $input
#          do
#            
#            line2="$(grep "$line" "$input" | tail -1)" #search a specific residue from the original list in the .pka file result
#            echo "$line2" > aux_ch #auxiliary file with the information above
#            #The next awk command organizes the information and assigns the charge for each residue case 
#            awk '$1 == "ASP" || $1 == "GLU" { if ($4 < 5) printf "%3d%5s%4s%2s%9.2f%11.2f    -1         in file %s\n",i,$1,$2,$3,$4,$5,file;
#                 else printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file}
#                 $1 == "ARG" || $1 == "LYS" || $1 == "HIS" { if ($4 < 5) printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file; 
#                 else printf "%3d%5s%4s%2s%9.2f%11.2f    +1         in file %s\n",i,$1,$2,$3,$4,$5,file}
#                 $1 == "" { printf "%3d  ---  -- -%9.2f%11.2f     0         in file %s\n",i,$4,$5,file} 
#                ' file="$input" i=$i aux_ch >> aux_charges
#           #awk '{printf "%3d%5s%4s%2s%9.2f%11.2f           in file %s\n",i,$1,$2,$3,$4,$5,file} #this is the raw way to print the information above without any charge parameter
#           #    ' file="$input" i=$i aux_ch >> aux_charges
#          done
#
#
#            #grep "$line" dir.pka | tail -1  
#
#        done < <(awk 'NF{printf "%s%4s%2s\n",$2,$3,$4}' residues_charges) #variable $line is gotten with a awk command from residues_charges file 
#             #$line contains name and number of the residue and chain that belongs, for instance: "ASP  57 B"
#
#        rm residues_charges
#        cd ../
#      fi
#    done
#    cd ../
#  fi
#done

#just here ok

#cd mutation_A13/opt_2A_A13/
#pwd each mutation folder


for i in `ls */` #in each folder
do

  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
    echo "$j"
    cd "$j"


  mkdir res_charges
  mv opt_$j/aux_charges res_charges/
  cp ../script_arc_auxmop.sh res_charges/
  cd opt_$j/
  for jj in `ls *.arc`
  do
    cp $jj ../res_charges/
  done
  
  cd ../res_charges/
  
  
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
  
  for jj in `ls *.arc`
  do
    ./script_arc_auxmop.sh "$jj" "$j" "neutral" #new mopac input neutral
  done
  
  
  
  for ii in `ls *.mop`
  do
  
    set_val="$(echo -n `awk '$7<0{printf "%s%d(-),",$4,$3}; $7>0{printf "%s%d(+),",$4,$3}' chosen_charges` | head -c -1)"
    echo " LET SITE=($set_val)" > new_input.mop
    
    printf "\n\n" >> new_input.mop
    awk 'NF==9{print $0}' $ii >> new_input.mop
  
  done
  
  $mopac16 new_input.mop 
  
  ./script_arc_auxmop.sh new_input.arc "$j" "charged"
  
  cp Opt_"$j"_neutral.mop comp1
  cp Opt_"$j"_charged.mop comp2
  #neutral as comp1 and charged as comp2
  
  # awk 'NR==FNR{c[$7]++;next};c[$7] == 0' comp1 comp2 > comp3    #--> comparison is just for a one column
  awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp1 comp2 > comp3
  awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp2 comp1 > comp4
  
  cp comp1 comp_final
  
  #well done!
  while read i; do echo "$i"; jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"; echo "$jj"; let jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"; echo "$jjj"; sed  -i "$jjj a $i" comp_final; done < <(awk '{print $0}' comp3) #add protons
  
  while read i; do echo "$i"; sed "/$i/d" comp_final > comp_final2; done < <(awk '{print $0}' comp4) #delete protons
  
  ./script_build_spmop.sh comp_final2
  
  $mopac16 comp_final2.mop 
  
  ./script_arc_to_pdb_s.sh comp_final2.mop

done

#-------------to continue
#jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"

#while read i
#do
#  jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"
#  let jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"
#  let nn=$jjj+1
#  awk -v res="$jj" -v nu=$jjj -v name="$i" ' $0 ~ res {if (NR==nu) printf "%s\n%s\n",$0,name; else print $0}' comp1 >> comp1_test_test
#done < <(awk '{print $0}' comp3)

#while read i; do echo "$i"; jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"; echo "$jj"; let jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"; echo "$jjj"; jjjj="$(awk -v w="$jj" -v c=$jjj -v f="$i" '($0 ~ w) && (NR==c) { printf "  %s\n",f; next}1 ($0 ~ w) && (NR!=c) { print $0}' comp1)"; echo "$jjjj"; done < <(awk '{print $0}' comp3)
#
#
#awk -v nu=$num ' /LYS/ {if (NR==nu) printf "%s\n   blabla\n",$0; else print $0NR}' comp1 >> comp1_test_test





#awk -v w="jj" '$0 ~ w {c=NR}END{printf "%d",c}' comp1 > aux_blablaa
#   '($4=="HIS" && $5=="B" && $6=="81)"){c[FNR]="%s%2s%4d";printf "%s",c[FNR]}'  
#jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"


#set_val="$(echo -n `awk '{printf "%s%d(-),",$4,$3}' chosen_charges` | head -c -1)"
#echo " LET SITE=($set_val)" > new_input.mop





#awk '$4=="HIS" && $5=="B" && $6=="81)" {print $0}' test1_A11 >> res_sp_test
#awk '$4=="HIS" && $5=="B" && $6=="81)" {print $0}' test1_A11 >> res_sp_test



#for i in `ls 1BX2_geom_chim-*`
#do
#
#  name="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1)"
#  mkdir "$name"
#  cp script_addH.sh "$name"/
#  cp "$i" "$name"/
#  cd "$name"/
#  ./script_addH.sh
#  cd ../
#  dir="$name/aux-$i"
#
#  j="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1 | tr -dc '0-9' | awk '{print substr ($0,0,2)}')"
#
#  let num=$(grep -n "V" $i | tail -1 | cut -d ":" -f1)
#
#  let ini=$(grep -n "P  $j" $i | head -1 | cut -d ":" -f1)-1
#  let fin=$(grep -n "P  $j" $i | tail -1 | cut -d ":" -f1)+1
#
#  awk 'NR == 1,NR == x {if (NF==12) print $0}' x="$ini" "$i" > aux.pdb 
#
#  let ini1=$(grep -n "P  $j" "$dir" | head -1 | cut -d ":" -f1)
#  let fin2=$(grep -n "P  $j" "$dir" | tail -1 | cut -d ":" -f1)
#
#  awk 'NR == x,NR == y {print $0}' x="$ini1" y="$fin2" "$dir" >> aux.pdb #$ini & $fin
#
#  awk 'NR == x,NR == y {print $0}' x="$fin" y="$num" "$i" >> aux.pdb #$ini & $num
#
#  awk '{gsub(/PROT/,"    "); print $0}' aux.pdb > aux2.pdb
#  awk 'BEGIN{i=1} NF=="12"{printf "%2s%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,i++,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux2.pdb > 1BX2_"$name".pdb
# 
#  mkdir mutation_"$name"
#  mv "$i" mutation_"$name"/
#  mv 1BX2_"$name".pdb mutation_"$name"/ 
#done
#
#rm aux.pdb aux2.pdb

echo "fin"
