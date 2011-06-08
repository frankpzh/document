%.eps: %.plot
	gnuplot $^

%.eps: %.fig
	fig2dev -L eps $^ $@

TITLE = compsc

EPS = selfemu.eps pack_state.eps arch.eps
EPS += perf_tp.eps perf_spec_req.eps perf_spec_250.eps perf_spec_resp.eps
EPS += timeline_compsc.eps timeline_pv.eps timeline_bond.eps

.PHONY: show
show: $(TITLE).pdf
	okular $(TITLE).pdf

$(TITLE).pdf: $(TITLE).tex $(TITLE)-bib.tex $(EPS)
	latex $(TITLE).tex
	latex $(TITLE).tex
	dvips -G0 -Ppdf -Pcmz -Pamz -o $(TITLE).ps $(TITLE).dvi
	ps2pdf $(TITLE).ps
	rm -f $(TITLE).dvi $(TITLE).log $(TITLE).aux $(TITLE).ent $(TITLE).ps $(TITLE).out

$(TITLE).tex: $(TITLE).org
	emacs -q --script org2tex.el

.PHONY: clean
clean:
	rm -f *~ *.bak *.eps $(TITLE).tex $(TITLE).pdf *.log
