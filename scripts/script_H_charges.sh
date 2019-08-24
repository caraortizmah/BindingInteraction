#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program builds a list with the name and number of residue and its required charge

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

  
for i in `ls */` #in each folder
do

  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
    echo "$j"
    cd "$j"

    #echo "residues with charges" > aux_charges
    for ii in `ls */`
    do
      jj="$(echo "$ii" | cut -d':' -f1)"
      if [ -d "$jj" ] && [ "$(echo "$jj" | cut -d'_' -f1)" == "opt" ]; then  # directory exists or not and if the name starts with "opt" 
        echo "$jj"
        cd "$jj"
        cp ../../residues_charges . #residues_charges contains all information about what the charged residues are
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

            #The following awk command organizes information and assigns charges for each residue case 


            awk '$1 == "ASP" || $1 == "GLU" { if ($4 < 5) printf "%3d%5s%4s%2s%9.2f%11.2f    -1         in file %s\n",i,$1,$2,$3,$4,$5,file;
                 else printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file}
                 $1 == "ARG" || $1 == "LYS" || $1 == "HIS" { if ($4 < 5) printf "%3d%5s%4s%2s%9.2f%11.2f     0         in file %s\n",i,$1,$2,$3,$4,$5,file; 
                 else printf "%3d%5s%4s%2s%9.2f%11.2f    +1         in file %s\n",i,$1,$2,$3,$4,$5,file}
                 $1 == "" { printf "%3d  ---  -- -%9.2f%11.2f     0         in file %s\n",i,$4,$5,file} 
                ' file="$input" i=$i aux_ch >> aux_charges

            # Raw way to print the information above without any charge parameter:
            #      awk '{printf "%3d%5s%4s%2s%9.2f%11.2f           in file %s\n",i,$1,$2,$3,$4,$5,file} 
            #          ' file="$input" i=$i aux_ch >> aux_charges
          done


        done < <(awk 'NF{printf "%s%4s%2s\n",$2,$3,$4}' residues_charges) #variable $line is gotten with an awk command from residues_charges file 
             #$line contains name and number of the residue, and name of the chain that belongs the residue to be charged. For instance: "ASP  57 B"

        rm residues_charges
        cd ../
      fi
    done
    cd ../
  fi
done

for i in `ls */` #in each folder
do

  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$(echo "$i" | cut -d':' -f1)" ]; then #if folder $i exists,  -d checks whether $jj directory exists or not
    echo "$j"
    res="$(echo "${i#*_}" | cut -d'/' -f1)"
    #res="$(echo "$j" | cut -d'/' -f1 | cut -d'_' -f2)" #receive the name of the folder next to the "_"
    cd "$j"

    for ii in `ls */`
    do
      jj="$(echo "$ii" | cut -d':' -f1)"
      if [ -d "$jj" ] && [ "$(echo "$jj" | cut -d'_' -f1)" == "opt" ]; then  # directory exists or not and if the name starts with "opt" 
        echo "$jj"
        # cd "$jj" opt folder


        mkdir res_charges #copying in that folder several scripts to be executed
        cp "$jj"aux_charges res_charges/
        cp ../script_arc_auxmop.sh res_charges/
        cp ../script_arc_to_pdb.sh res_charges/
        cp ../script_arc_to_pdb_s.sh res_charges/
        cp ../script_build_spmop.sh res_charges/
        cp ../script_other_sp.sh res_charges/
        cd "$jj"/
        for jjj in `ls *.arc`
        do
          cp $jjj ../res_charges/
        done
        
        cd ../res_charges/
        
        
        #`cat aux_charges | awk NF==10'{print $0}' | wc -l`  --> total number of lines with charged residues information
        #BEGIN{...} assignation of data in arrays a and b
        #END{...} for ... this bucle evaluates each 2 steps 
        #END{...} if ... due to the conditional it is possible to compare each to lines (file_alternate_state.pka vs file.pka)
        #END{...} c[j] this vector has all filtered information over charged residues
        # |
        # v
        # detailed description of the awk above 
        awk -v fin=`cat aux_charges | awk NF==10'{print $0}' | wc -l` '
            BEGIN{i=1; j=0} NF==10{a[i]=$7; b[i]=$0; i++} 
            END{for (i=1;i<=fin;i=i+2) {
                    j++; 
                    if (a[i]==a[i+1]){c[j]=b[i]} 
                    else if(a[i]==0){c[j]=b[i]} 
                    else if (a[i+1]==0){c[j]=b[i+1]} 
                    else{c[j]="It is a mistake"} 
                    printf "%s ---- \n",c[j] }}' aux_charges >> chosen_charges
        
        for ff in `ls *.arc`
        do
          ./script_arc_auxmop.sh "$ff" "$res" neutral #new mopac input neutral done       
        done

        
        for kk in `ls *.mop`
        do
        
          set_val="$(echo -n `awk '$7<0{printf "%s%d(-),",$4,$3}; $7>0{printf "%s%d(+),",$4,$3}' chosen_charges` | head -c -1)"
          echo " LET SITE=($set_val)" > new_input.mop #assignment of the residues to be charged (protonated or deprotonated) in the flag of the new input in mopac
          
          printf "\n\n" >> new_input.mop
          awk 'NF==9{print $0}' $kk >> new_input.mop #putting geometry of the molecule before assigning new hydrogens in the selected residues
        
        done
        
        $mopac16 new_input.mop #executing mopac in the input
        
        ./script_arc_auxmop.sh new_input.arc "$res" charged

        #Procedure below replaces geometries of atoms of selected residues to be charged in the optimized geometry 
        #The new geometry is the initial geometry for the mono-substitution (mutation) of the original molecule
        
        cp Opt_"$res"_neutral.mop comp1
        cp Opt_"$res"_charged.mop comp2
        #neutral as comp1 and charged as comp2
        
        # awk 'NR==FNR{c[$7]++;next};c[$7] == 0' comp1 comp2 > comp3    #--> comparison is just for a single column
        awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp1 comp2 > comp3
        awk 'NR==FNR{c[$7]++;d[$8]++;e[$9]++;next};c[$7] == 0 || d[$8] == 0 || e[$9] == 0' comp2 comp1 > comp4
        
        cp comp1 comp_final
        
        #well done!
        while read i; do echo "$i"; jj="$(echo "$i" | awk '{printf "%s%2s%4d\n",$4,$5,$6}')"; echo "$jj"; let jjj="$(awk -v w="$jj" '$0 ~ w {print NR}' comp1 | tail -1)"; echo "$jjj"; sed  -i "$jjj a $i" comp_final; done < <(awk '{print $0}' comp3) #adding protons

        cp comp_final aux_comp_final
        
        while read i; do echo "$i"; sed "/$i/d" aux_comp_final > comp_final2; mv comp_final2 aux_comp_final; done < <(awk '{print $0}' comp4) #deleting protons
        
        mv aux_comp_final comp_final2

        ./script_build_spmop.sh comp_final2

        ./script_other_sp.sh comp_final2
 
        #Calculation for the complex, receptor and ligand
        $mopac16 comp_final2.mop
        $mopac16 comp-pep_final2.mop
        $mopac16 pep_final2.mop
        
        #creating from .arc file a .pdb file
        ./script_arc_to_pdb_s.sh comp_final2.arc
        ./script_arc_to_pdb_s.sh comp-pep_final2.arc
        ./script_arc_to_pdb_s.sh pep_final2.arc
        
        mkdir complex_"$res"
        mkdir comp-pep_"$res"
        mkdir pep_"$res"

        #moving into the new folders
        mv comp_final2.* complex_"$res"/
        mv comp-pep_final2.* comp-pep_"$res"/
        mv pep_final2.* pep_"$res"/
        cd ../

      fi
    done
    cd ../
  fi
done

echo "fin"
