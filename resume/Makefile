OUTPUT="Resume-Frank.pdf"

$(OUTPUT): resume.dvi
	dvipdf $^ $@

resume.dvi: resume.tex
	latex $^

.PHONY: show
show: $(OUTPUT)
	okular $^ || evince $^

.PHONY: clean
clean:
	rm -f *.dvi *.log *.pdf *~
