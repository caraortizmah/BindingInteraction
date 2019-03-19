TOPDIR=.
ifndef SRCDIR
	SRCDIR=$(shell pwd)
endif

include $(TOPDIR)config_path

SUBDIRS = BindingInteraction src
ALLSUBDIRS = $(SUBDIRS) doc

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  clean      to remove build files"
	@echo "  html       to make standalone HTML files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  text       to make plain text files"
	@echo "  changes    to make an overview over all changed/added/deprecated items"
	@echo "  doctest    to run doctests in the documentation"
	@echo "  pydoc-topics  to regenerate the pydoc topics file"
	@echo "  dist       to create a \"dist\" directory with archived docs for download"
	@echo "  check      to run a check for frequent markup errors"

clean:
	find . -name "*.pyc" -exec rm -f {} \;
	find . -name "*~" -exec rm -f {} \;
	find . -name "*.out" -exec rm -f {} \;
	find . -name "*.arc" -exec rm -f {} \;
	find . -name "*.log" -exec rm -f {} \;
	find . -name "*.csv" -exec rm -f {} \;
	rm -rf $(TOPDIR)/doc/html
	rm -rf $(TOPDIR)/doc/latex
	rm config_path

install:
	mkdir -p $(BI)
	cp -rf * $(BI)
	rm
	mkdir

init:
      pip install -r requirements.txt

test:
      nosetests tests
