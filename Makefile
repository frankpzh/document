.PHONY: help
help:
	@echo Frank Pan\'s power makefile
	@echo ---------------------------------------------------
	@echo set-emacs: setting your emacs config

PWD=$(shell pwd)

.PHONY: set-emacs
set-emacs:
	rm -rf ~/.emacs.d
	cd ~ && ln -s $(PWD)/lisp .emacs.d
