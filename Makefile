TOPDIR=.
ifndef SRCDIR
	SRCDIR=$(shell pwd)
endif

include $(TOPDIR)config_path

SUBDIRS = BindingInteraction src
ALLSUBDIRS = $(SUBDIRS) doc

help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  clean        to remove build files"
	@echo "  install      to install program on disk"
	@echo "  init         to install requirements of BindingInteraction"
	@echo "  test         to test the finished installation"
	@echo "  howto        to show instructions in HTML format"
	@echo "  latex        to make LaTeX files, you can set PAPER=a4 or PAPER=letter"

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
	cd ../
	mv BindingInteraction/ $(PREFIX)
	cd $(BI)/BindingInteraction/
	$(PYTHON) compiler.py
	cd ../
	mkdir -p bin
	mv BindingInteraction/*.pyc bin/
	mkdir -p src
	cd src/
	mkdir py
	mkdir sh
	cd ../
	mv BindingInteraction/*.py py/
	mv script/*.sh sh/
	cd
	mkdir -p $(SCRATCH)

init:
      pip install -r requirements.txt

test:
      nosetests tests

howto:
      firefox	 Instructions_installation.html

