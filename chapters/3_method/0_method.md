# Methodology

In this chapter, we outline the three studies and methodologies used for each.
First, I will give a brief reasoning to why changesets are a good choice for a
training corpus.  Second, we discuss the datasets and benchmarks used
throughout this work.  Next, we describe the approach for an application of
topic models for feature location.  We will then discuss work on the
application of topic models for developer identification.  Finally, I will
discuss an approach for using a singular topic model for both of these tasks.


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

For the first two Research Problems, there do exist various datasets and
benchmarks for each [@Dit-etal_2013; @Moreno-etal_2014; @Kagdi-etal_2012;
@Linares-Vasquez-etal_2012].  However, *Research Problem 3* introduces a
complication to using these benchmarks.  The overlap of these goldsets is
small, making it difficult to determine whether a technique is performing well
or not because of the approach or if it happens to just be a challenging query
for that technique.  \todo{gross sentence} Hence, we have created our own
benchmark fit for evaluating both an FLT and DIT.

The 7 subjects of our studies vary in size and application domain.
BookKeeper is a distributed logging service\footnote{\url{http://zookeeper.apache.org/bookkeeper/}}.
Derby is a relational database management system\footnote{\url{http://db.apache.org/derby/}}.
Mahout is a tool for scalable machine learning\footnote{\url{https://mahout.apache.org/}}.
OpenJPA is object/relational mapping tool\footnote{\url{http://openjpa.apache.org/}}.
Pig is a platform for analyzing large datasets\footnote{\url{http://pig.apache.org/}}.
Tika is a toolkit for extracting metadata and text from various types of files\footnote{\url{http://tika.apache.org/}}.
ZooKeeper is a tool that works as a coordination service to help build distributed applications\footnote{\url{http://zookeeper.apache.org/bookkeeper/}}.
Table \ref{table:subjects} summarizes the sizes of each system's corpora and
dataset.

\input{tables/subjects}

\todo{subjects table needs classes/methods breakdown? does not seem relevant
since we don't actually use it}

We chose these systems for our preliminary work because developers use
descriptive commit messages that allow for easy traceability linking to issue
reports.  Further, all projects use JIRA as an issue tracker, which has been
found to encourage more accurate linking [@Bissyande-etal_2013].

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
