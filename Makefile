%.pdf: %.ps
	@ps2pdf $^ $@

%.ps: %.dvi
	@dvips -G0 -Ppdf -Pcmz -Pamz -o $@ $^

%.dvi: %.tex
	@cd $(dir $^) && latex $(notdir $^)

%.tex: %.org
	@scripts/org2tex.el $^

.PHONY: help
help:
	@echo Frank Pan\'s power makefile
	@echo ---------------------------------------------------
	@echo set-emacs: setting emacs config
	@echo set-git:   setting git config
	@echo
	@echo WARNING: set-* will kill your old config

PWD=$(shell pwd)

.PHONY: set-emacs
set-emacs:
	rm -rf ~/.emacs.d
	cd ~ && ln -s $(PWD)/lisp .emacs.d

.PHONY: set-git
set-git:
	rm -rf ~/.gitconfig
	cd ~ && ln -s $(PWD)/.gitconfig
