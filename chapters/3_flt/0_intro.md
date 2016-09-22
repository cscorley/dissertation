# Feature Location {#chap:flt}

Feature location is a frequent and fundamental activity for a developer tasked
with changing a software system.  Whether a change task involves adding,
modifying, or removing a feature, a developer cannot complete the task without
first locating the source code that implements the feature.  The
state-of-the-practice in feature location is to use an IDE tool based on
keyword or regular expression search, but @Ko-etal_2006 observed such tools
leading developers to failed searches nearly 90% of the time.

## Motivation {#sec:flt-motivation}

The state-of-the-art in feature location [@Dit-etal_2013a] is to use a feature
location technique (FLT) based, at least in part, on text retrieval (TR).  The
standard methodology [@Marcus-etal_2004] is to extract a document for each
class or method in a source code snapshot, to train a TR model on those
documents, and to create an index of the documents from the trained model.
Topic models (TMs) [@Blei_2012] such as latent Dirichlet allocation (LDA)
[@Blei-etal_2003] are the state-of-the-art in TR and outperform vector-space
models (VSMs) in the contexts of natural language [@Deerwester-etal_1990;
@Blei-etal_2003] and source code [@Poshyvanyk-etal_2007; @Lukins-etal_2010].
Yet, modern TMs such as online LDA [@Hoffman-etal_2010] natively support only
the online addition of a new document, whereas VSMs also natively support
online modification or removal of an existing document.  So, TM-based FLTs
provide the best accuracy, but unlike VSM-based FLTs, they require
computationally-expensive retraining subsequent to source code changes.

@Rao_2013 proposed FLTs based on customizations of LDA and latent semantic
indexing (LSI) that support online modification and removal.  These FLTs
require less-frequent retraining than other TM-based FLTs, but the remaining
cost of periodic retraining inhibits their application to large software, and
the reliance on customization hinders their extension to new TMs.

We envision an FLT that is:

1) accurate like a TM-based FLT,
2) inexpensive to update like a VSM-based FLT,
3) and extensible to accommodate any off-the-shelf TR model that supports
   online addition of a new document.

Unfortunately, our vision is incompatible with the standard methodology for
FLTs.  Existing VSM-based FLTs fail to satisfy the first criteria, and existing
TM-based FLTs fail to satisfy the second or third criteria.  Indeed, given the
current state-of-the-art in TR, it is impossible for a FLT to satisfy all three
criteria while following the standard methodology.

In this work, we propose a new methodology for FLTs.  Our methodology is to
extract a document for each changeset in the source code history and to train a
TR model on the changeset documents, and then to extract a document for each
source file in a source code snapshot and to create an index of the
source file documents from the trained (changeset) model.  This new
methodology stems from four key observations:

- Like a source code file, a changeset contains program text.
- Unlike a source code file, a changeset is immutable.
- A changeset corresponds to a commit.
- An atomic commit involves a single feature.

It follows from the first two observations that it is possible for an FLT
following our methodology to satisfy all three of the aforementioned criteria.
The next two observations influence the training and indexing steps of our
methodology, which have the conceptual effect of relating source files to
changeset topics.  By contrast, the training and indexing steps of the standard
methodology have the conceptual effect of relating files to file topics.

## Background {#sec:flt-background}

![Typical feature location process\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)

The left side of Figure \ref{fig:snapshot-flt} illustrates the document
extraction process.  A document extractor takes a source code snapshot as input
and produces a corpus as output.  Each document in the corpus contains the
words associated with a source code entity, in this case a source code file.
The text extractor is the first part of the document extractor and produces a
token stream for each document.  The preprocessor is the second part of the
document extractor and applies a series of transformations to each token and
produces one or more words from the token.

The right side of Figure \ref{fig:snapshot-flt} illustrates the retrieval
process.  The main prerequisite of the retrieval process is to build the search
engine.  We construct the search engine from a topic model trained from a
corpus and an index of a corpus inferred from that model.  This means that
an index is no more than each input document's thematic structure (i.e., the
document's inferred topic distribution).

The primary function of the search engine is to rank documents in relation to
the query [@Croft-etal_2010].  When using a TM-based approach, the engine must
first infer the thematic structure of the query.  This allows for a pairwise
classification of the query to each document in the index and ranks the
documents based on the similarities of their thematic structures.

