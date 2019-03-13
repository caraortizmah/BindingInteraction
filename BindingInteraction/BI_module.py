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
    self.c_lett = ''
    self.n_subs = 0
    self.res_name = ''
    self.ad_n_subs = 0
    self.arg_dict = {}
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

    while (type(chain_letter) == int) or (not chain_letter.strip()):
      chain_letter = v_input("** Put the letter of the chain: ")
    while (type(number_substitutions) == str) or (number_substitutions == 0):
      number_substitutions = v_input("** Put the number of mono-substitutions ")
    while (type(residue_name) == int) or (not residue_name.strip()):
      residue_name = v_input("** Put the name of the residue ")
    mol.get_features(chain_letter, number_substitutions, residue_name)

  def get_features(self, chain_letter, number_substitutions, residue_name):
    """
    get_features receives letter of the chain, number of mono-substitutions and residue name.
    The residue name is written as three letter code for aminoacids e.g.:
    >>> object.get_features("P", 9, "ASP")
    """
    self.c_lett = chain_letter
    self.n_subs = number_substitutions
    self.res_name = residue_name

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
      arg_d[key] = value
    self.ad_n_subs = number_substitutions
    self.arg_dict = arg_d

  def __del__(self):
    print ("** Destructor deleting object ", self.mol)


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

  mol_name = ''
  while (not str(mol_name).strip()):
    mol_name=v_input("** Put the name of the protein:  ")
  mol=Molecule(mol_name)
  mol.manager_mol()