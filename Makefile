PAPER 		= proposal

LATEX 		= pdflatex
BIBTEX		= bibtex

GRAPHICS	= graphics

EPS_GFX		= $(shell echo $(GRAPHICS)/*.eps)
GEN_GFX 	= $(addsuffix .pdf, $(basename $(EPS_GFX)))
GFX_FILES	= #$(GEN_GFX)

CLS_FILES	= $(shell find . -name '*.cls')
TEX_FILES	= $(shell find . -name '*.tex')
BIB_FILES	= $(shell find . -name '*.bib')
MD_FILES	= $(shell find . -name '*.md')
EDIT_FILES=$(shell cat $(PAPER).tex | grep "\\input{" | sed -e 's/\\input{\(.*\)}/\1\.tex/')

DEP_FILES	= $(CLS_FILES) $(TEX_FILES) $(BIB_FILES) $(GFX_FILES)


all: $(TEX_FILES) $(PAPER).pdf

$(TEX_FILES): $(MD_FILES)
	pandoc --to=latex markdown/01_introduction.md \
		--output=chapters/01_introduction.tex
	pandoc --to=latex markdown/02_related.md \
		--output=chapters/02_related.tex
	pandoc --to=latex markdown/03_previous.md \
		--output=chapters/03_previous.tex
	pandoc --to=latex markdown/04_proposed.md \
		--output=chapters/04_proposed.tex
	pandoc --to=latex markdown/05_schedule.md \
		--output=chapters/05_schedule.tex
	pandoc --to=latex markdown/06_conclusion.md \
		--output=chapters/06_conclusion.tex

$(PAPER).pdf: $(DEP_FILES)
	$(LATEX) $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)

edit: $(EDIT_FILES)
	vim $(EDIT_FILES)

tidy:
	$(RM) *.aux
	$(RM) *.log
	$(RM) *.out
	$(RM) *.toc
	$(RM) *.bbl
	$(RM) *.blg
	$(RM) *.lot
	$(RM) *.lof


clean: tidy
	$(RM) $(PAPER).pdf

%.pdf: %.eps
	epstopdf --outfile=$@ $<

OS = $(shell uname -s)
ifeq ($(strip $(OS)),Linux)
	PDF_VIEW = xdg-open
else
	PDF_VIEW = open -a /Applications/Preview.app
endif

view: $(PAPER).pdf
	$(PDF_VIEW) $(PAPER).pdf &
