%.pdf: %.tex
	xelatex $^

.PHONY: all
all: resume.pdf resume-zhao.pdf

.PHONY: show
show:
	okular *.pdf || evince *.pdf

.PHONY: clean
clean:
	rm -f *.log *.pdf *~
