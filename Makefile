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
FIG_FILES	= $(shell find ./figures)
MD_FILES	= $(shell find . -name '*.md' | sort)
CHAP_FILES	= $(shell find ./chapters -name '*.md' | sort)
EXTRA_FILES	= $(shell find ./extra -name '*.md' | sort)

GENERATED = $(shell find ./extra -name '*.md' | sort | sed -e 's/^\.\/extra\///g' | sed -e 's/\.md//g')

DEP_FILES	= metadata.yaml $(CLS_FILES) $(TEX_FILES) $(BIB_FILES) $(GFX_FILES) $(MD_FILES) $(FIG_FILES)


all: $(PAPER).pdf

$(GENERATED) :: $(EXTRA_FILES)
	mkdir -p tmp
	pandoc \
		--chapters \
		--from=markdown \
		--to=latex \
		extra/$@.md -o tmp/$@.tex

$(PAPER).pdf: $(DEP_FILES) $(GENERATED)
	pandoc \
		--bibliography ${HOME}/papers/papers.bib \
		--filter pandoc-citeproc \
		--smart \
		--toc \
		--chapters \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).pdf

debug: $(DEP_FILES) $(GENERATED)
	pandoc \
		--bibliography ${HOME}/papers/papers.bib \
		--natbib \
		--smart \
		--toc \
		--chapters \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).tex

$(PAPER).html: $(DEP_FILES) $(GENERATED)
	pandoc \
		--standalone \
		--filter pandoc-citeproc \
		--smart \
		--toc \
		--chapters \
		--listings \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).html

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
