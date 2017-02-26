# Methodology {#chap:methodology}

\todo{this needs to be re-written to match reality}

In this chapter, we outline the three studies and methodologies used for each.
First, we give our reasoning to why changesets are a good choice for a training
corpus.  Second, we discuss the datasets and benchmarks used throughout this
work.  Next, we describe our approach for an application of topic models for
feature location and how it contrasts to the state-of-the-practice.  We then
discuss work on the application of topic models for developer identification.
Finally, we discuss an approach for using a singular topic model for both of
these tasks.

## Why changesets?

We choose to train the model on changesets, rather than another source of
information, because they also represent what we are primarily interested in:
program features.  A single changeset gives us a view of an addition, removal,
or modification of a single feature.  A developer can to some degree comprehend
what a changeset accomplishes by examining it, much like examining a source
file.

While a snapshot corpus has documents that represent a program, a changeset
corpus has documents that represent programming.  If we consider every
changeset affecting a particular source code entity, then we gain a
sliding-window view of that source code entity over time and the contexts those
changes took place within.  Figure \ref{fig:sliding} shows an example, where
green areas denote text added and red areas denote text removed in that
changeset.  Here, the summation of all changes affecting a class over its
lifetime would approximate the same words in its current version.

![Changesets over time approximate a
Snapshot\label{fig:sliding}](figures/sliding_window_example.pdf)

Changeset topic modeling is akin to summarizing code snippets with machine
learning [@Ying-Robillard_2013], where in our case a changeset gives a
snippet-like view of the code required to complete a task.  For example, in
Figure \ref{fig:diff}, we can see the entire method affected by the changeset.

Additionally, @Vasa-etal_2007 observe that code rarely changes as software
evolves.  The implication is that the topic modeler will see changesets
containing the same source code entity only a few times, perhaps only once.
Since topic modeling a snapshot only sees an entity once, topic modeling a
changeset can miss no information.

Using changesets also implies that the topic model may gain some noisy
information from these additional documents, especially removals.  However,
@Vasa-etal_2007 also observe that code is less likely to be removed than it is
to be changed.  This implies that the noisy information would likely remain in
both snapshot-based models and changeset-based models.

Indeed, it appears desirable to remove changesets from the model that are old
and no longer relevant.  There would be no need for this because online LDA
already contains features for increasing the influence newer documents have on
the model, thereby decaying the affect of the older documents on the model.

## Datasets and Benchmarks

For the first two Research Problems, there does exist various datasets and
benchmarks for each [@Dit-etal_2013; @Moreno-etal_2014; @Kagdi-etal_2012;
@Linares-Vasquez-etal_2012].  However, *Research Problem 3* (RP3) introduces a
complication to using these benchmarks. RP3 requires high overlap of the
benchmarks.  The overlap of these benchmarks is small or non-existent, making
it difficult to determine whether a technique is performing well or not because
of the approach or if it happens to just be a challenging query for that
technique.  \todo{gross sentence} Hence, we have created our own benchmark fit
for evaluating both an FLT and DIT.

The 6 subjects of our studies vary in size and application domain.
BookKeeper is a distributed logging service\footnote{\url{http://zookeeper.apache.org/bookkeeper/}}.
<!-- Derby is a relational database management system\footnote{\url{http://db.apache.org/derby/}}.  -->
Mahout is a tool for scalable machine learning\footnote{\url{https://mahout.apache.org/}}.
OpenJPA is object-relational mapping tool\footnote{\url{http://openjpa.apache.org/}}.
Pig is a platform for analyzing large datasets\footnote{\url{http://pig.apache.org/}}.
Tika is a toolkit for extracting metadata and text from various types of files\footnote{\url{http://tika.apache.org/}}.
ZooKeeper is a tool that works as a coordination service to help build distributed applications\footnote{\url{http://zookeeper.apache.org}}.
Table \ref{table:subjects} summarizes the sizes of each system's corpora and
dataset.

\input{tables/subjects}

We chose these systems for our work because developers use descriptive commit
messages that allow for easy traceability linking to issue reports.  Further,
all projects use JIRA as an issue tracker, which has been found to encourage
more accurate traceability link recovery [@Bissyande-etal_2013]. Finally, each
system varies in domain and in size, in terms of developers, changesets, and
number of source code files.

To build our dataset we mine the Git repository for information about each
commit: the committer, message, and files changed.  We use the files changed
information during the location-based approach.  Using the message, we extract
the traceability links to issues in JIRA with the regular expression: `%s-\d+`,
where `%s` is the project's name (e.g., BookKeeper).  This matches for
JIRA-based issue identifiers, such as `BOOKKEEPER-439` or `TIKA-42`.

From the issue reports, we extract the version the issue marked as fixed in.
We ignore issues that are not marked with a fixed version.  We also extract the
title and description of the issue.

We construct two goldsets for each commit linked to an issue report.  The first
goldset is for evaluating FLTs, and contains the files, classes, and methods
changed by the linked commit.  The second goldset is for evaluating DITs, and
contains the developer(s) that committed those changes.

## Metric

## Setting {#sec:setting}

\todo{need to edit this so it is general across all RPs}
\todo{add note about where this may differ?}

Our document extraction process is shown on the left side of Figure
\ref{fig:changeset-flt}.  We implemented our document extractor in Python v2.7
using the [Dulwich library](http://www.samba.org/~jelmer/dulwich/) for
interacting with the source code repository.  We extract documents from both a
snapshot of the repository at a tagged snapshot and each commit reachable from
that tag's commit.  The same preprocessing steps are employed on all extracted
documents.

To extract text from the changesets, we look at the \texttt{git diff} between
two commits.  In our changeset text extractor, we extract all text related to
the change, e.g., context, removed, and added lines; metadata lines are ignored.
Note that we do not consider where the text originates from, only that it is
text changed by the commit.

After extracting tokens, we split the tokens based on camel case, underscores,
and non-letters.  We only keep the split tokens; original tokens are discarded.
We normalize to lower case before filtering non-letters, English stop
words [@Fox_1992], Java keywords, and words shorter than three characters
long.  We do not stem words.

We implemented our modeling using the Python library Gensim
[@Rehurek-Sojk_2010], version 0.12.1. We use the same configurations on each
subject system.  We do not try to adjust parameters between the different
systems to attempt to find a better, or best, solution; rather, we leave them
the same to reduce confounding variables.  We do realize that this may lead to
topic models that may not be best-suited for feature location on a particular
subject system.  However, this constraint gives us confidence that the
measurements collected are fair and that the results are not influenced by
selective parameter tweaking.  Again, our goal is to show the performance of
the changeset-based FLT against snapshot-based FLT under the same conditions.

Gensim's LDA implementation is based on an online LDA by @Hoffman-etal_2010 and
uses variational inference instead of a collapsed Gibbs sampler.  Unlike Gibbs
sampling, in order to ensure that the model converges for each document, we set
the model to take $1000$ iterations over a document during the inference step,
and as many passes over the corpus as needed until there is little improvement
in the evidence lower bound. That is, we allow the model to behave as a batch,
or offline, model.  We set the following LDA parameters for all systems: $500$
topics, a symmetric $\alpha=1/K$, and a symmetric $\eta=1/K$.  These are
default values for $\alpha$ and $\eta$ in Gensim, and have been found to work
well for the FLT task [@Biggers-etal_2014].

For the historical simulation, since we must use online training, we found it
beneficial to consider two new parameters for online LDA: $\kappa$ and
$\tau_0$.  As noted in @Hoffman-etal_2010, it is beneficial to adjust $\kappa$
and $\tau_0$ to higher values for smaller mini-batches, e.g. a single
changeset.  These two parameters control how much influence a new mini-batch
has on the model when training.  We follow the recommendations in
@Hoffman-etal_2010, choosing $\tau_0=1024$ and $\kappa=0.9$ for all systems,
because the historical simulation often has mini-batch sizes in single digits.
Additionally, since we are operating in fully online mode, we cannot take
multiple passes over the entire corpus as that would defeat the purpose of a
historical simulation.

### On LDA

\todo{Explain randomness and setting seed?}
