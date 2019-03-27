TOPDIR=./
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
	@echo "  update       to recompile python files of src/ and update executables in bin/ folder (for your own develop)"
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
	mkdir -p $(BI)
	cp -rfu BindingInteraction/* $(BI)
	cd $(BI)
	$(PYTHON) BindingInteraction/compiler.py
	cd BindingInteraction/
	$(PYTHON) compiler.py
	cd ../
	mkdir -p bin
	mkdir -p src
	mv BindingInteraction/*.pyc bin/
	mv BindingInteraction/*.py src/
	mv Scripts/*.sh src/
	rm -rf BindingInteraction/
	rm -rf Scripts/
	mkdir -p work
	mkdir -p $(SCRATCH)
	mkdir -p conf

update:
	cd $(BI)
	cp src/*.py bin/
	cd bin/
	$(PYTHON) compiler.py
	rm *.py
	cd ../

init:
	pip install -r requirements.txt

test:
	dir="1"
	@echo 'test '
	@echo 'pwd $(PWD)...'
	ifeq ($(dir),1)
		@echo 'same pwd'
	endif

howto:
	firefox	 Instructions_installation.html

