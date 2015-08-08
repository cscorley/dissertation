## Feature location {#study-flt}

Feature location is a frequent and fundamental activity for a developer tasked
with changing a software system. Whether a change task involves adding,
modifying, or removing a feature, a developer cannot complete the task without
first locating the source code that implements the feature. The
state-of-the-practice in feature location is to use an IDE tool based on
keyword or regular expression search, but @Ko-etal_2006 observed such tools
leading developers to failed searches nearly 90% of the time.

### Motivation

The state-of-the-art in feature location [@Dit-etal_2013a] is to use a
feature location technique (FLT) based, at least in part, on text retrieval
(TR). The standard methodology [@Marcus-etal_2004] is to extract a document
for each class or method in a source code snapshot, to train a TR model on
those documents, and to create an index of the documents from the trained
model. Topics models (TMs) [@Blei_2012] such as latent Dirichlet allocation
(LDA) [@Blei-etal_2003] are the state-of-the-art in TR and outperform
vector-space models (VSMs) in the contexts of natural
language [@Deerwester-etal_1990; @Blei-etal_2003] and source
code [@Poshyvanyk-etal_2007; @Lukins-etal_2010]. Yet, modern TMs such as
online LDA [@Hoffman-etal_2010] natively support only the online addition
of a new document, whereas VSMs also natively support online modification or
removal of an existing document. So, TM-based FLTs provide the best accuracy,
but unlike VSM-based FLTs, they require computationally-expensive retraining
subsequent to source code changes.

@Rao_2013 proposed FLTs based on customizations of LDA and latent semantic
indexing (LSI) that support online modification and removal. These FLTs require
less-frequent retraining than other TM-based FLTs, but the remaining cost of
periodic retraining inhibits their application to large software, and the
reliance on customization hinders their extension to new TMs.

We envision an FLT that is:

1. accurate like a TM-based FLT,
2. inexpensive to update like a VSM-based FLT,
2. and extensible to accommodate any off-the-shelf TR model that supports online addition of a new document.

Unfortunately, our vision is incompatible with the standard methodology for
FLTs. Existing VSM-based FLTs fail to satisfy the first criteria, and existing
TM-based FLTs fail to satisfy the second or third criteria. Indeed, given the
current state-of-the-art in TR, it is impossible for a FLT to satisfy all three
criteria while following the standard methodology.

In this work, we propose a new methodology for FLTs. Our methodology is to
extract a document for each changeset in the source code history and to train a
TR model on the changeset documents, and then to extract a document for each
class or method in a source code snapshot and to create an index of the
class/method documents from the trained (changeset) model. This new methodology
stems from four key observations:

- Like a class/method definition, a changeset contains program text.
- Unlike a class/method definition, a changeset is immutable.
- A changeset corresponds to a commit.
- An atomic commit involves a single feature.

It follows from the first two observations that it is possible for an FLT
following our methodology to satisfy all three of the criteria above. The next
two observations influence the training and indexing steps of our methodology,
which have the conceptual effect of relating classes (or methods) to changeset
topics. By contrast, the training and indexing steps of the standard
methodology have the conceptual effect of relating classes to class topics (or
methods to method topics).

### Background {#flt-background}

![Typical feature location process\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)

The left side of Figure \ref{fig:snapshot-flt} illustrates the document extraction
process.  A document extractor takes a source code snapshot as input and
produces a corpus as output.  Each document in the corpus contains the words
associated with a source code entity, such as a class or method.  The text
extractor is the first part of the document extractor and parses the source
code to produce a token stream for each document.  The preprocessor is the
second part of the document extractor.  It applies a series of transformations
to each token and produces one or more words from the token.

The right side of Figure \ref{fig:snapshot-flt} illustrates the retrieval
process. The main prerequisite of the retrieval process is to build the search
engine. We construct the search engine from a topic model trained from a
corpus and an index of that corpus inferred from that model. This means that an
index is no more than each input document's thematic structure (i.e., the
document's inferred topic distribution).

The primary function of the search engine is to rank documents in relation to
the query [@Croft-etal_2010].  First, when using a TM-based approach, the
engine must first infer the thematic structure of the query.  This allows for a
pairwise classification of the query to each document in the index and ranks
the documents based on the similarities of their thematic structures.

### Proposal

In this proposal, we introduce a topic-modeling-based FLT in which we
incrementally build the model from source code *changesets*. By training an
online learning algorithm using changesets, the FLT maintains an up-to-date
model without incurring the non-trivial computational cost associated with
retraining traditional FLTs.

#### Approach {#flt-approach}

![Feature location using changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

The overall difference in our methodology and the standard methodology
described in Section \ref{flt-background} is minimal. For example, compare
Figures \ref{fig:snapshot-flt} and \ref{fig:changeset-flt}. In the changeset
approach, we only need to replace the training documents while the remainder of
the approach remains the same.

The changeset approach requires two types of document extraction:
the snapshot of the state of source code at a commit of interest, such as
a tagged release, and every changeset in the source code history leading up to
the same commit of interest.  The left side of Figure \ref{fig:changeset-flt}
illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in
Section \ref{flt-background} while the document extractor for the changesets
parses each changeset for the removed, added, and context lines.  From there,
the text extractor tokenizes each line.  The same preprocessor transformations
as before occur in both the snapshot and changesets.  The snapshot vocabulary
is always a subset of the changeset vocabulary [@Corley-etal_2014].

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process. The key intuition to our methodology is that a topic model such as LDA
or LSI can infer *any* document's topic proportions regardless of the documents
used to train the model.  In fact, this is also what determining the topic
proportions of a user-created query relies on. Likewise, so are other unseen
documents. In our approach, the seen documents are changesets and the unseen
documents are the source code entities of the snapshot.

Hence, we train a topic model on the changeset corpus and use the model to
index the snapshot corpus.  Note that we never construct an index of the
changeset documents used to train the model.  In our approach, we only
use the changesets to continuously update the topic model and only use the
snapshot for indexing.

To leverage the online functionality of the topic models, we can also intermix
the model training, indexing, and retrieval steps.  First, we initialize a
model in online mode.  We update the model with new changesets whenever a
developer makes a commit.  That is, with changesets, we incrementally update a
model and can query it at any moment. This will allow for a *historical
simulation* of how a changeset-based FLT would perform in a realistic scenario.

#### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

RQ 4.2.1
:   Is a changeset-based FLT as accurate as a snapshot-based FLT?

RQ 4.2.2
:   Does the accuracy of a changeset-based FLT fluctuate as a project evolves?

##### Methodology {#flt-methodology}

For snapshots, the process is straightforward and corresponds to
Figure \ref{fig:snapshot-flt}.  First, we train a model on the snapshot corpus using
batch training.  That is, the model can see all documents in the corpus at once.
Then, we infer an index of topic distributions with the snapshot corpus.  For
each query in the dataset, we infer the query's topic distribution and rank each
entity in the index with pairwise comparisons.

In terms of changesets, the process varies slightly from a snapshot approach,
as shown in Figure \ref{fig:changeset-flt}.  First, we train a model of the
changeset corpus using batch training.  Second, we infer an index of topic
distributions with the snapshot corpus.  Note that we *do not* infer topic
distributions with the changeset corpus.  Finally, for each query in the
dataset, we infer the query's topic distribution and rank each entity in the
snapshot index with pairwise comparisons.

For the historical simulation, we take a slightly different approach.  We first
determine which commits relate to each query (or issue) and partition
mini-batches out of the changesets.  We then proceed by initializing a model for
online training.  Using each mini-batch, or partition, we update the model.
Then, we infer an index of topic distributions with the snapshot corpus at the
commit the partition ends on.  We also obtain a topic distribution for each
query related to the commit.  For each query, we infer the query's topic
distribution and rank each entity in the snapshot index with pairwise
comparisons. Finally, we continue by updating the model with the next
mini-batch.

Since @Dit-etal_2013 extracted the dataset from the commit that implemented the
change, our partitioning is inclusive of that commit.  That is, we update the
model with the linked commit and infer the snapshot index from that commit.
This allows our evaluations to capture any entities added to address the issue
report, as well as changed entities, but does not capture any entities removed
by the change.

##### Subject Systems

There are two publicly-available and recently published datasets usable for
this study. Between these two datasets are over 1200 defects and features from
14 open source Java projects. Choosing a publicly-available dataset allows us
to set this work in context of work completed by other researchers.

Table \ref{table:flt-datasets} summarizes the subject systems from the datasets.
The first is a dataset of four software systems by @Dit-etal_2013 and contains
method-level goldsets. This dataset was automatically extracted from changesets
that relate to the queries (issue reports). The second is a dataset of 14
software systems by @Moreno-etal_2014 and contains class-level goldsets. This
dataset was automatically extracted from patches attached to issue reports. The
four software systems in the first dataset also appear in the second, supplying
us with both class- and method-level goldsets for the queries.


Subject System       Features   Classes   Methods
--------------      ---------  --------  --------
ArgoUML v0.22        91         287       701
ArgoUML v0.24        52         154       357
ArgoUML v0.26.2      209        706       1560
BookKeeper v4.1.0    40         152
Derby v10.7.1.1      32         55
Derby v10.9.1.0      95         410
Hibernate v3.5.0b2   20         53
Jabref v2.6          39         131       280
jEdit v4.3           150        361       748
Lucene v4.0          35         103
Mahout v0.8          30         159
muCommander v0.8.5   92         303       717
OpenJPA v2.0.1       35         82
OpenJPA v2.2.0       18         53
Pig v0.8.0           85         442
Pig v0.11.1          48         129
Solr v4.4.0          55         189
Tika v1.3            18         34
ZooKeeper v3.4.5     80         285
Total                1224       4088      4363
--------------      ---------  --------  --------

Table: Feature location subject systems and goldset sizes \label{table:flt-datasets}

ArgoUML is a UML diagramming tool^[<http://argouml.tigris.org/>].
BookKeeper is a distributed logging service^[<http://zookeeper.apache.org/bookkeeper/>].
Derby is a relational database management system^[<http://db.apache.org/derby/>].
Hibernate is a object/relational mapping framework^[<http://hibernate.org/>].
jEdit is a text editor^[<http://www.jedit.org/>].
JabRef is a BibTeX bibliography management tool^[<http://jabref.sourceforge.net/>].
Lucene is an information retrieval library^[<http://lucene.apache.org/core/>].
Mahout is a tool for scalable machine learning^[<https://mahout.apache.org/>].
muCommander is a cross-platform file manager^[<http://www.mucommander.com/>].
OpenJPA is object/relational mapping tool^[<http://openjpa.apache.org/>].
Pig is a platform for analyzing large datasets^[<http://pig.apache.org/>].
Solr is a search platform^[<http://lucene.apache.org/solr/>].
Tika is a toolkit for extracting metadata and text from files^[<http://tika.apache.org/>].
ZooKeeper is a tool that works as a coordination service to help build distributed applications^[<http://zookeeper.apache.org/bookkeeper/>].

##### Data Collection and Analysis

To evaluate the performance of a topic-modeling-based FLT we cannot use
measures such as precision and recall. This is because the FLT creates the
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs. The effectiveness measure is the rank of the first relevant document and
represents the number of source code entities a developer would have to view
before reaching a relevant one. The effectiveness measure allows evaluating the
FLT by using the mean reciprocal rank (MRR).

To answer RQ1, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{flt-methodology}. We then calculate the MRR between
the two sets of effectiveness measures. We use the Wilcoxon signed-rank test
with Holm correction to determine the statistical significance of the
difference between the two rankings. To answer RQ2, we run the historical
simulation as outlined in Section \ref{flt-methodology} and compare it to the
results of batch changesets from RQ1. Again, we calculate the MRR and use the
Wilcoxon signed-rank test.

