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
MD_FILES	= $(shell find ./chapters -name '*.md' | sort)

DEP_FILES	= metadata.yaml $(CLS_FILES) $(TEX_FILES) $(BIB_FILES) $(GFX_FILES) $(MD_FILES)


all: $(PAPER).pdf

$(PAPER).pdf: $(DEP_FILES)
	pandoc \
		--filter pandoc-citeproc \
		--toc \
		--chapters \
		--listings \
		--template=./AlabamaManuscript.latex \
		-A extra/appendix.md \
		-H extra/header.tex \
		metadata.yaml $(MD_FILES) -o $(PAPER).pdf 
	pandoc \
		--filter pandoc-citeproc \
		--toc \
		--chapters \
		--listings \
		-A extra/appendix.md \
		metadata.yaml $(MD_FILES) -o $(PAPER).tex
	pandoc -s $(PAPER).tex -o $(PAPER).html
	$(RM) $(PAPER).tex

edit: 
	vim chapters/*

tidy:
	$(RM) *.aux
	$(RM) *.log
	$(RM) *.out
	$(RM) *.toc
	$(RM) *.bbl
	$(RM) *.blg
	$(RM) *.lot
	$(RM) *.lof
	$(RM) *.nlo
	$(RM) *.nls
	$(RM) *.bst
	$(RM) *.ilg


clean: tidy
	$(RM) $(PAPER).pdf
	$(RM) $(PAPER).tex
	$(RM) $(PAPER).html

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
