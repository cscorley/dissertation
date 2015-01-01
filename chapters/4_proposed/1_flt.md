## Feature location {#study-flt}

Feature location is a program comprehension activity in which a developer
inspects source code to locate the classes or methods that implement a feature
of interest.

### Motivation

Many feature location techniques (FLTs) are based on text retrieval models, and
in such FLTs it is typical for the models to be built from source code
snapshots. However, source code evolution leads to model obsolescence and thus
to the need to retrain the model from the latest snapshot.

### Background {#flt-background}

![Typical feature location process\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)

The left side of Figure \ref{fig:snapshot-flt} illustrates the document
extraction process. A document extractor takes source code as input and
produces a corpus as output. Each document in the corpus contains the words
associated with a source code entity such as a class or method. The text
extractor is the first part of the document extractor. It parses the source
code and produces a token stream for each class. The preprocessor is the second
part of the document extractor. It applies a series of transformations to each
token and produces one or more words from the token.

The right side of Figure \ref{fig:snapshot-flt} illustrates the retrieval
process. The main prerequisite of the retrieval process is to build the search
engine. The search engine is constructed from the topic model trained from the
corpus and an index of that corpus inferred from that model, known as $\theta$.
The primary function of the search engine is to rank documents in relation to
the query. The search engine performs a pairwise classification of the query to
each document and ranks the documents according score.

To accomplish the classification step using a topic model, the search engine
infers $\theta_{Snapshot}$, i.e., the topic-document probability distribution
of each document in the snapshot corpus, as well as $\theta_{Query}$, i.e., the
topic-document probability distribution of the query. Then a similarity measure
for probability distributions, such as cosine similarity or Hellinger distance,
can be used to make pairwise comparisons between $\theta_{Query}$ and
$\theta_{Snapshot}$.


### Proposal

In this proposal, we introduce a topic-modeling-based FLT in which the model is built
incrementally from source code *changesets*. By training an online learning
algorithm using changesets, the FLT maintains an up-to-date model without
incurring the non-trivial computational cost associated with retraining
traditional FLTs.

#### Approach {#flt-approach}

![Feature location using changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

The changeset topic modeling approach requires two types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release, and one for the every changeset in the
source code history leading up to that commit. The left side of
Figure \ref{fig:changeset-flt} illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in
Section \ref{flt-background}. The document extractor for the changesets parses
each changeset for the removed, added, and context lines. From there, each line
is tokenized by the text extractor. In a changeset it may be desirable to parse
further for source code entities using island grammar parsing [@Moonen_2001],
although not necessary for this approach. It may also be desirable to only use
portions of the changeset, such as only using added or removed lines. The same
preprocessor transformations as before also occur in changesets.

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process. The key intuition to our approach is that a topic model such as LDA or
LSI can infer any given document's topic proportions regardless of the
documents used to train the model. Hence, we train a topic model on the
changeset corpus, but search for related documents over the snapshot corpus. In
the search engine, we can use a dynamic programming to keep $\theta_{Snapshot}$
up-to-date as new changesets are added to the model. That is, upon a update to
the model, new inferences of only the source code documents affected by this
changeset are made. Additionally, we can then query the model as needed and
rank the results of that query against $\theta_{Snapshot}$. Note that we never
infer a $\theta_{Changeset}$ for the changeset documents on which the model is
built.

To leverage the online functionality of the topic models, we can also intermix
the model training and retrieval steps. First, we initialize a model in online
mode. Then, as changes are made, the model is updated with the new changesets
as they are committed. That is, with changesets, we incrementally update a
model and can query it at any moment. This insight means that we can also
evaluate our approach *temporally*. That is, we we can approximate how the FLT
would perform throughout the evolution of a project.

#### Evaluation

In this section we describe the design of a case study in which we
compare topic models trained on changesets to those trained on snapshots.
For this work, we pose the following research questions:

RQ1
:   How well do changeset-based topic models perform for feature location?

RQ2
:   How well do *temporal simulations* of changeset-based topic models perform for feature location?

##### Subject Systems

There are two publicly-available and recently published datasets that could be
used in this study. Between these two datasets are over 1200 defects and
features from 14 open source Java projects. Choosing a publicly-available
dataset allows for this work to be set in context of work completed by other
researchers.

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

Table: Subject Systems and Goldset Sizes \label{table:flt-datasets}


ArgoUML is a UML CASE tool that supports standard UML diagrams^[<http://argouml.tigris.org/>].
BookKeeper is a distributed logging service^[<http://zookeeper.apache.org/bookkeeper/>].
Derby is a relational database management system^[<http://db.apache.org/derby/>].
Eclipse is an intergrated development environment to develop applications in various programming languages^[<https://www.eclipse.org/>].
Hibernate is a java package used to work with relational databases^[<http://hibernate.org/>].
JEdit is a Java text editor^[<http://www.jedit.org/>].
JabRef is a tool for managing bibliographical reference data^[<http://jabref.sourceforge.net/>].
Lucene is an information retrieval library written in Java^[<http://lucene.apache.org/core/>].
Mahout is a tool for scaleable machine learning^[<https://mahout.apache.org/>].
MuCommander is a cross-platform file manager^[<http://www.mucommander.com/>].
OpenJPA is object relational mapping tool^[<http://openjpa.apache.org/>].
Pig is a platform for analyzing large datasets consisting of high-level language^[<http://pig.apache.org/>].
Solr is an enterprised search platform^[<http://lucene.apache.org/solr/>].
Tika is a toolkit for extracting metadata and text from various types of files^[<http://tika.apache.org/>].
ZooKeeper is a tool that works as a coordination service to help build distributed applications^[<http://zookeeper.apache.org/bookkeeper/>].

##### Methodology


For snapshots, the process is straightforward. First, we build a model in batch
mode from the snapshot corpus. That is, the model can see all documents in the
corpus at once. Then, we infer a $\theta_{Snapshot}$ from the snapshot corpus
and a $\theta_{Queries}$ from the query corpus. Finally, we classify the
results from both $\theta$s.

For changesets, the process is varies slightly from a snapshot approach. First,
we build a model in batch mode from the changeset corpus. Then, we infer a
$\theta_{Snapshot}$ from the snapshot corpus and a $\theta_{Queries}$ from the
query corpus. Note that we \emph{do not} infer a $\theta_{Changesets}$ from the
changeset corpus from which the model was built! Finally, we classify the
results from both $\theta$s.

For the temporal simulation, we can take a slightly different approach. We
first determine which changesets relate to an issue and partition mini-batches
out of the changesets. Then, we initialize a model in online mode. For each
mini-batch, or partition, we update the model with that mini-batch. Then, we
infer a $\theta_{Snapshot}$ from the snapshot corpus and a retrieve the
$\theta_{Queries}$ for the queries related to this changeset. Finally, we
classify the results from both $\theta$s.

Since the @Dit-etal_2013 dataset was extracted from the commit that implemented
the change, our partitioning should be inclusive of that commit. That is, we
update the model with the linked commit and infer the $\theta_{Snapshot}$ from
that commit. This allows our evaluation to capture any entities added to
address the issue report, as well as changed entities, but does not capture any
entities that were removed by the change.

##### Data Collection and Analysis

To evaluate the performance of a topic-modeling-based FLT we cannot use
measures such as precision and recall. This is because the FLT creates the
rankings pairwise, causing every entity being searched to appear in the
rankings. @Poshyvanyk-etal_2007 define an effectiveness measure that can be
used for topic-modeling-based FLTs. The effectiveness measure is the rank of
the first relevant document and represents the number of source code entities a
developer would have to view before reaching a relevant one. The effectiveness
measure allows evaluating the FLT by using the mean reciprocal rank (MRR). We
can also look at only the top-k recommendations in the list, giving us the
measures of precision@k and recall@k.

For any execution of the experiment, we calculate the MRR of each approach.
We use the Wilcoxon signed-rank test with Holm correction to determine
the statistical significance of the difference between any two rankings.


