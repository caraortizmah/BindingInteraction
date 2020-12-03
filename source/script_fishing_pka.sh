#!/bin/bash

cd tobe_charged/

#fold="1kpv41_A19_6A/: 1kpv41_A19_8A/:"
#fold="1kpv4_A12_2A/:"
#for i in $fold #in each folder
for i in `ls */` #in each folder
do

  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
    echo "$j"
    cd "$j"

    #echo "residues with charges" > aux_charges
    #for ii in `ls */`
    #do
    #  jj="$(echo "$ii" | cut -d':' -f1)"
    #  if [ -d "$jj" ] && [ "$(echo "$jj" | cut -d'_' -f1)" == "opt" ]; then  # directory exists or not and if the name starts with "opt" 
    #    echo "$jj"
    #    cd "$jj"
    cp ../residues_charges . #residues_charges contains all information about what the charged residues are
    echo "residues with charges" > aux_charges
    #this file will host information of charges of some residues for each mutation taking into account residues_charges file
    echo "       Group       pKa      model-pKa     charge" >> aux_charges 

    let i=0
    while read line #line variable has been written at the end of the while sentence
    do
      let i+=1
      #echo "$line"
        
      for input in `ls *.pka` #look up the two available .pka files --> $input
      do
            
        line2="$(grep "$line" "$input" | tail -1)" #search a specific residue from the original list in the .pka file result
        echo "$line2" > aux_ch #auxiliar file with the information above
        #The next awk command organizes the information and assigns the charge for each residue case 
        awk '$1 == "ASP" || $1 == "GLU" { if ($4 < 7) printf "%3d%5s%4s%2s%9.2f%11.2f    -1         in file %s\n",i,$1,$2,$3,$4,$5,file;
             else printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file}
             $1 == "ARG" || $1 == "LYS" || $1 == "HIS" { if ($4 < 7) printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file; 
             else printf "%3d%5s%4s%2s%9.2f%11.2f    +1         in file %s\n",i,$1,$2,$3,$4,$5,file}
             $1 == "" { printf "%3d  ---  -- -%9.2f%11.2f     0         in file %s\n",i,$4,$5,file} 
            ' file="$input" i=$i aux_ch >> aux_charges
        #awk '{printf "%3d%5s%4s%2s%9.2f%11.2f           in file %s\n",i,$1,$2,$3,$4,$5,file} #this is the raw way to print the information above without any charge parameter
        #    ' file="$input" i=$i aux_ch >> aux_charges
      done
      
      #grep "$line" dir.pka | tail -1  

    done < <(awk 'NF{printf "%s%4s%2s\n",$2,$3,$4}' residues_charges) #variable $line is gotten with a awk command from residues_charges file 
             #$line contains name and number of the residue and chain that belongs, for instance: "ASP  57 B"

    rm residues_charges
    cd ../
  fi
done
cd ..
echo "fin"
