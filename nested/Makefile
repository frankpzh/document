TITLE = nested
EPS = nested1.eps nested2.eps nested3.eps nested4.eps
EPS += nested5.eps nested6.eps nested10a.eps nested10b.eps

%.eps: %.png
	sam2p $^ EPS: $@

$(TITLE).pdf: $(TITLE).tex $(TITLE).bib $(EPS)
	latex $(TITLE).tex
	bibtex $(TITLE)
	latex $(TITLE).tex
	latex $(TITLE).tex
	dvips -G0 -Ppdf -Pcmz -Pamz -o $(TITLE).ps $(TITLE).dvi
	ps2pdf $(TITLE).ps
	rm -f $(TITLE).dvi $(TITLE).log $(TITLE).ent $(TITLE).ps $(TITLE).out $(TITLE).bbl $(TITLE).blg $(TITLE).aux

$(TITLE).tex: $(TITLE).org
	../scripts/org2tex.el $^

.PHONY: show
show: $(TITLE).pdf
	evince $(TITLE).pdf || okular $(TITLE).pdf

.PHONY: clean
clean:
	rm -f *~ *.bak *.eps $(TITLE).tex $(TITLE).pdf *.log
