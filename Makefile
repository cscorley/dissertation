PAPER 		= dissertation
DRAFT 		= draft

LATEX 		= pdflatex -halt-on-error
BIBTEX		= bibtex
PANDOC		= pandoc +RTS -V0 -RTS

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

URL="https://github.com/cscorley/dissertation/commits"

$(DRAFT).pdf: natbib

$(PAPER).pdf: nodraft

$(PAPER): $(PAPER).pdf

$(DRAFT): $(DRAFT).pdf

all: $(PAPER).pdf $(DRAFT).pdf

$(GENERATED) :: $(EXTRA_FILES)
	mkdir -p tmp && touch tmp/git-log.tex
	./latex-git-log --width=8 --git-c-add=$(URL) --commitlimit=89 > tmp/git-log.tex || true
	$(PANDOC) \
		--chapters \
		--from=markdown \
		--to=latex \
		extra/$@.md -o tmp/$@.tex

pandoc: $(DEP_FILES) $(GENERATED)
	$(PANDOC) \
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
	$(PANDOC) \
		--natbib \
		--smart \
		--toc \
		--chapters \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		-M draft:Yes \
		-M fontfamily:libertine \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(DRAFT).tex

nodraftpandoc: $(DEP_FILES) $(GENERATED)
	$(PANDOC) \
		--natbib \
		--smart \
		--toc \
		--chapters \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		-M draft:No \
		-M fontfamily:times \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).tex

natbib: debug
	cp ~/papers/papers.bib .
	$(LATEX) $(DRAFT)
	$(LATEX) $(DRAFT)
	$(BIBTEX) $(DRAFT)
	$(LATEX) $(DRAFT)
	$(LATEX) $(DRAFT)

nodraft: nodraftpandoc
	cp ~/papers/papers.bib .
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)

count: nodraft
	texcount -sum $(PAPER).tex | grep "Sum count"

$(PAPER).html: $(DEP_FILES) $(GENERATED)
	$(PANDOC) \
		--standalone \
		--filter pandoc-citeproc \
		--smart \
		--toc \
		--chapters \
		--listings \
		--from=markdown \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).html

edit:
	cp ~/papers/papers.bib .
	vim $(CHAP_FILES)

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
	$(RM) $(DRAFT).pdf
	$(RM) $(DRAFT).tex
	$(RM) $(DRAFT).html
	$(RM) -r tmp

%.pdf: %.eps
	epstopdf --outfile=$@ $<

OS = $(shell uname -s)
ifeq ($(strip $(OS)),Linux)
	PDF_VIEW = xdg-open
else
	PDF_VIEW = open -a /Applications/Preview.app
endif

view: $(DRAFT).pdf
	$(PDF_VIEW) $(DRAFT).pdf &
