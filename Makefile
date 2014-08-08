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

DEP_FILES	= $(CLS_FILES) $(TEX_FILES) $(BIB_FILES) $(GFX_FILES)


all: $(TEX_FILES) $(PAPER).pdf

$(TEX_FILES): $(MD_FILES)
	pandoc --to=latex markdown/00_abstract.md \
		--output=tex/00_abstract.tex
	pandoc --to=latex markdown/01_introduction.md \
		--output=tex/01_introduction.tex
	pandoc --to=latex markdown/02_related.md \
		--output=tex/02_related.tex
	pandoc --to=latex markdown/03_previous.md \
		--output=tex/03_previous.tex
	pandoc --to=latex markdown/04_proposed.md \
		--output=tex/04_proposed.tex
	pandoc --to=latex markdown/05_schedule.md \
		--output=tex/05_schedule.tex
	pandoc --to=latex markdown/06_conclusion.md \
		--output=tex/06_conclusion.tex
	pandoc --to=latex markdown/99_appendix.md \
		--output=tex/99_appendix.tex
	pandoc --to=latex markdown/extra/abbreviations.md \
		--output=tex/abbreviations.tex
	pandoc --to=latex markdown/extra/dedication.md \
		--output=tex/dedication.tex
	pandoc --to=latex markdown/extra/acknowledgments.md \
		--output=tex/acknowledgments.tex

$(PAPER).pdf: $(DEP_FILES)
	$(LATEX) $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)

edit: 
	vim markdown/*

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
