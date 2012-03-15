SHELL := /bin/bash

%.eps: %.plot %.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

%.eps: %.fig
	fig2dev -L eps $^ $@

%.eps: %.png
	sam2p $^ EPS: $@

$(TITLE).pdf: $(TITLE).tex $(TITLE).bib $(EPS)
	latex $(TITLE).tex
	bibtex $(TITLE)
	latex $(TITLE).tex
	latex $(TITLE).tex
	dvips -G0 -Ppdf -Pcmz -Pamz -o $(TITLE).ps $(TITLE).dvi
	ps2pdf $(TITLE).ps
	rm -f $(TITLE).dvi $(TITLE).log $(TITLE).aux $(TITLE).ent $(TITLE).out $(TITLE).bbl $(TITLE).blg

$(TITLE).tex: $(TITLE).org
	../scripts/org2tex.el $^

.PHONY: spellcheck
spellcheck: $(TITLE).org
	../scripts/org2plain.sh $^ > $(TITLE).txt
	aspell -l en -c $(TITLE).txt
	rm -f $(TITLE).txt*

.PHONY: show
show: $(TITLE).pdf
	okular $(TITLE).pdf || evince $(TITLE).pdf

.PHONY: clean
clean:
	rm -f $(TITLE).dvi $(TITLE).aux $(TITLE).ent $(TITLE).out $(TITLE).bbl $(TITLE).blg $(TITLE).toc
	rm -f *~ *.bak *.eps $(TITLE).tex $(TITLE).pdf *.log

