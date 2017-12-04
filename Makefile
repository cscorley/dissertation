PAPER 		= dissertation
DRAFT 		= draft

LATEX 		= pdflatex -halt-on-error
BIBTEX		= bibtex
PANDOC		= pandoc #+RTS -V0 -RTS

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
	cp ~/papers/papers.bib .
	mkdir -p tmp
	$(PANDOC) \
		--top-level-division=chapter \
		--from=markdown+smart+definition_lists \
		--to=latex+smart \
		extra/$@.md -o tmp/$@.tex

appendix: $(DEP_FILES) $(GENERATED)
	cp -R figures tmp
	cp -R tables tmp
	sed -E -ibak -e "s/input\{/input{tmp\//g" ./tmp/appendices.tex
	find tmp -name "*.tex" | xargs sed -E -ibak -e "s/label\{/label{app:/g"

pandoc: appendix
	$(PANDOC) \
		--filter pandoc-citeproc \
		--toc \
		--top-level-division=chapter \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		--from=markdown+smart+definition_lists  \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).pdf

debug: appendix
	$(PANDOC) \
		--natbib \
		--toc \
		--top-level-division=chapter \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		-M draft:Yes \
		--from=markdown+smart+definition_lists  \
		metadata.yaml $(CHAP_FILES) -o $(DRAFT).tex

nodraftpandoc: appendix
	$(PANDOC) \
		--natbib \
		--toc \
		--top-level-division=chapter \
		--listings \
		--template=./Manuscript.latex \
		-H extra/header.tex \
		-M draft:No \
		-M fontfamily:times \
		--from=markdown+smart+definition_lists  \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).tex

natbib: debug
	$(LATEX) $(DRAFT)
	$(LATEX) $(DRAFT)
	$(BIBTEX) $(DRAFT)
	$(LATEX) $(DRAFT)
	$(LATEX) $(DRAFT)
	$(LATEX) $(DRAFT)

nodraft: nodraftpandoc
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(BIBTEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)
	$(LATEX) $(PAPER)

count: nodraft
	texcount -sum $(PAPER).tex | grep "Sum count"

plain: appendix
	$(PANDOC) \
		--natbib \
		--toc \
		--top-level-division=chapter \
		--listings \
		--from=markdown+smart+definition_lists  \
		--to=plain \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).txt

$(PAPER).html: appendix
	$(PANDOC) \
		--standalone \
		--filter pandoc-citeproc \
		--toc \
		--top-level-division=chapter \
		--listings \
		--from=markdown+smart+definition_lists  \
		metadata.yaml $(CHAP_FILES) -o $(PAPER).html

edit:
	cp ~/papers/papers.bib .
	vim -c Goyo $(CHAP_FILES)

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
