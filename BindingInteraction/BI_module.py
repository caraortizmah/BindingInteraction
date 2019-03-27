"""
*************************************
BindingInteraction -v1.0.1

@author Carlos Andres Ortiz-Mahecha
  (email: caraortizmah@gmail.com)
  (email: caraortizmah@unal.edu.co)

@brief Binding Interaction module
This module initializes all information necessary to call each script in the pipeline.
This tool allows to calculate ligand-receptor binding energy of proteins.
*************************************
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from platform import python_version
from collections import OrderedDict

import io
import sys

def v_input(inp):
  """
  check version of python to decide if use input() or raw_input()
  if python version is greater or equal than 3, program uses input("")
  else program uses raw_input("")
  """

  v=python_version()
  if int(v[0]) >= 3:
    int_inp = input(inp)
    try:
      out = int(int_inp)
    except:
      out = int_inp
  else:
    int_inp = raw_input(inp)
    try:
      out = int(int_inp)
    except:
      out = int_inp
  return out

def manager():
  """
  Manager
  """
  print("** Select an option:")
  print("** 1. Assign information of project")
  print("** 2. Open, save or edit information from  paths")
  print("** 3. Exit")

  option = v_input("** ")
  while (type(option) == str) or ((option != 1) and (option != 2) and (option != 3)):
    option = v_input("** Select just a number in the three options ")

  if (option == 1):
    print("** Assigning information")
    mol.manager_mol()
  elif (option == 2):
    print("** Options from file")
    paths.selection()
  elif (option == 3):
    print("** Exit program molecule... bye")
    sys.exit()
  else:
    print("** Something goes wrong... bye")
    sys.exit()


class Molecule:

  """
  This class saves information about the protein and mono-substitutions:
  1. Name of protein.
  2. Number of substitutions.
  3. Residue name.
  4. Chain letter.

  """

  def __init__(self, molecule):
    """
    class Molecule needs a name of the protein
    """
    self.mol = molecule
    self.path = "../conf/" + molecule + ".csv"
    self.c_lett = ''
    self.n_subs = 0
    self.res_name = ''
    self.res_num = 0
    self.ad_n_subs = 0
    self.arg_dict = {}
    self.mol_info= {}
    self.is_adv_feat= False
    print ("** creating object ...", self.mol)
    print ("** This program needs features for ", self.mol, " to continue (default argument)")

  def manager_mol(self):
    """
    class manager_mol interacts with the user and asks for molecule information
    """
    print ("** Do you want to use features (1) or advanced features (2) ?")
    case = v_input("** So, select one of them: ")
    if case == 1:
      mol.features()
    elif case == 2:
      print ("case 2")
      mol.advanced_features()
    else:
      print ("** Error: Choose a number")
      mol.manager_mol()

  def features(self):
    """
    The residue name is written as three letter code for aminoacids e.g.:
    letter of the chain = A
    number of substitutions = 9
    residue name = ASP
    """
    chain_letter = ''
    residue_name = ''
    number_substitutions = 0
    residue_num = 0

    while (type(chain_letter) == int) or (not chain_letter.strip()):
      chain_letter = v_input("** Put the letter of the chain: ")
    while (type(number_substitutions) == str) or (number_substitutions == 0):
      number_substitutions = v_input("** Put the number of mono-substitutions ")
    while (type(residue_num) == str) or (residue_num == 0):
      residue_num = v_input("** Put the number of the residue position ")
    while (type(residue_name) == int) or (not residue_name.strip()):
      residue_name = v_input("** Put the name of the residue ")
    mol.get_features(chain_letter, number_substitutions, residue_num, residue_name)

  def get_features(self, chain_letter, number_substitutions, residue_number, residue_name):
    """
    get_features receives letter of the chain, number of mono-substitutions and residue name.
    The residue name is written as three letter code for aminoacids e.g.:
    >>> object.get_features("P", 9, "ASP")
    """
    self.c_lett = chain_letter
    self.n_subs = number_substitutions
    self.res_name = residue_name
    self.res_num = residue_number
    self.is_adv_feat = False

  def advanced_features(self):
    """
    Residue keyword is written as the chain letter and number residue;
    residue name is written as chain letter and number residue e.g.:
    A11=ASP (chain letter 'A' and number residue 11 = Aspartic Acid)
    """
    args = ''
    n_s = 0

    while (type(n_s) == str) or (n_s == 0):
      n_s = v_input("** Put the number of mono-substitutions ")
    print("** Keyword residue = P11 and Residue name = ASP. Argument: P11=ASP")
    print("** For putting several arguments: P11=ASP, P12=VAL, ... , P19=ARG ")
    while (type(args) == int) or (not args.strip()):
      args = v_input("** Put the residue keyword and the residue name separated by '=', followed by ',' to write the second or more arguments: ")
    mol.get_advanced_features(n_s, args)

  def get_advanced_features(self, number_substitutions, arguments):
    """
    get_advanced_features receives number of substitutions and several residue names for each
      mono-substitution as follows:
      residue keyword is written as the chain letter and number residue;
      residue name is written as chain letter and number residue e.g.:
    A11 ='ASP' (chain letter 'A' and number residue 11 = Aspartic Acid)
    >>> object.get_advanced_features(3, "P11=ASP, P12=ALA, P13=VAL")
    """
    arg_d={}
    arg = arguments.split(",")
    for i in arg:
      key, value = i.split("=")
      arg_d[key] = value #building a dictionary
    self.ad_n_subs = number_substitutions
    self.arg_dict = arg_d
    self.is_adv_feat = True

  def get_mols(self):
    """
    prepare all information of molecule to be saved and return it in a dictionary
    """
    res_code=self.c_lett + str(self.res_num)
    self.arg_dict = {}
    self.mol_info['project']=self.mol
    self.mol_info['path']=self.path
    self.mol_info['number_of_subs']=self.n_subs + self.ad_n_subs
    self.mol_info['residue_position']=self.res_num
    if (not self.is_adv_feat):
      for i in self.n_subs:
        self.arg_dict[res_code]=self.res_name

  def __del__(self):
    print ("** Destructor deleting object ", self.mol)

class Actions:

  """
  This class presents some actions to execute over features of actions such as:
  1. Open
  2. Edit
  3. Save
  4. Get information
  """

  def __init__(self):
    """
    Verify if the file of paths exist or not
    """
    init = info()
    self.isfile=init.isfile
    self.mol_dict_file = {}

  def options(self):
    """
    Select and option to load from file, save, edit or adding file with molecule program
    """

    print("** Select an option:")
    print("** 1. Load information.")
    print("** 2. Save information.")
    print("** 3. Return")

    option = v_input("** ")
    clause = (option != 1) and (option != 2) and (option != 3) and (option != 4)
    while (type(option) == str) or (clause):
      print("option ",option)
      option = v_input("** Select just a number in the three options ")

    if (option == 1):
      print("** Loading information from file")
      file.open(True)
      file.options()
    elif (option == 2):
      print("** Assigning new parameters")
      file.edit()
    elif (option == 3):
      print("** Returning... bye")
      manager()
    else:
      print("** Something goes wrong... bye")
      manager()

  def open(self, fromfile):
    """
    open path files if exits
    """
    if (fromfile):
      if (self.isfile):
        print("** %s already exist ", mol.path)
        print("** Molecule information from the file")
        print("**")
        print("** Project \t\t Path")

        mol_file=file.get_mol_file()
        for key in mol_file.keys():
          if (str(mol_file[key])==''):
            print("** ", key, "\t\tInformation of molecule no assigned")
          else:
            print("** ", key, "\t\t ", mol_file[key])
      else:
        print("** %s does not exits ", mol.path)
        print("**")
        print("")
    else:
      print("** Paths files from temporary memory")
      print("**")
      print("** Project \t\t Path")
      mol=mol.get_mols()
      for key in mol.keys():
        if ((str(mol[key])=='') or (str(mol[key])=='-')):
          print("** ", key, "\t\tInformation of molecule no assigned")
        else:
          print("** ", key, "\t\t ", mol[key])

  def edit(self):
    """
    create or save mol.path ../conf/name_project.csv
    """
    #mol.mol_info has temporary information
    #mol.mol_info pass information to molecule
    molecule=mol.get_mols()
    print("**")
    print("")
    print("")
    file.open(True)
    file.open(False)
    if (self.isfile):
      print("Edition")
      print("**Do you want to save files of temporary memory to file?")
      dec=v_input("**y/n")
      dec=dec.upper()
      while (type(dec) == int) or (not dec.strip()) or ((dec!='Y') and (dec!='N')):
        dec = v_input("** Select 'y' or 'n': ")
      if (dec=='Y'):
        for key in molecule.keys():
          if (molecule[key]==''):
            mol.mol_info[key]="-"
        file.save_mols_file()
        print("** files saved")
      else:
        print("Returning... bye")
        manager()
    else:
      print("** Saving...")
      file.save_mols_file()
      print("** files saved")
    mol.manager_mol()

  def save_mols_file(self):
    """
    save all paths saved in a directory
    """
    try:
      with open(mol.path, "w") as f:
        writer = csv.writer(f, delimiter=",")
        for key in mol.mol_info.keys():
          if ((mol.mol_info[key]!='') and (mol.mol_info[key]!='-')):
            f.write("%s , %s\n"%(key,mol.mol_info[key]))
        for key in mol.arg_dict.keys():
          if ((mol.arg_dict[key]!='') and (mol.arg_dict[key]!='-')):
            f.write("%s , %s\n"%(key,mol.arg_dict[key]))

      print("** information saved in %s ", mol.path)
      self.isfile = True
    except IOError:
      print("** Something goes wrong: I/O error")
    except:
      print("** Something goes wrong")

  def get_mol_file(self):
    """
    extract all paths saved in a directory
    """
    if (self.isfile):
      with open(mol.path, "r") as f:
        creader = csv.reader(f, delimiter=",")
        for row in creader:
          self.mol_dict_file[row[0]]=row[1]
    return self.mol_dict_file

if __name__ == '__main__':

  print("************************************************************")
  print("**                                                        **")
  print("**              BINDINGINTERACTION 1.0.1                  **")
  print("**                Molecule Information                    **")
  print("**                                                        **")
  print("************************************************************")
  print("")
  print("")
  print("")

  file = Actions()
  mol_name = ''
  print("Assignation of project name")
  while (not str(mol_name).strip()):
    mol_name=v_input("** Put the name of the protein:  ")
  mol=Molecule(mol_name)
  manager()
