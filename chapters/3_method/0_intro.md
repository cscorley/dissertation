# Methodology {#chap:methodology}

\todo{this needs to be re-written to match reality}

In this chapter, we describe our approach and the three studies to address each
research problem.  We will first describe the basic approach of a
snapshot-based topic model search engine, and then give our reasoning for why
changesets may be good choice for a training corpus.  Then, we discuss the
datasets and benchmarks used throughout this work.  Next, we describe our
approach for an application of topic models for feature location and how it
contrasts to the state-of-the-practice.  We then discuss work on the
application of topic models for developer identification.  Finally, we discuss
an approach for using a singular topic model for both of these tasks.

## Modeling Changeset Topics

In this section we describe our approach to a modeling changeset topics and how
we apply them for feature location and developer identification.

![Constructing a search engine with snapshots\label{fig:snapshot-flt}](figures/snapshot-flt.pdf)
![Constructing a search engine from changesets\label{fig:changeset-flt}](figures/changeset-flt.pdf)

### Approach overview

The overall difference in our approach and the standard approach
described in Section \ref{sec:method-background} is minimal.  For example,
compare Figures \ref{fig:snapshot-flt} and \ref{fig:changeset-flt}.  In the
changeset approach, we only need to replace the training documents while the
remainder of the approach remains the same.

The changeset-based approach requires two types of document extraction: a
corpus at the point of interest, or snapshot, and every changeset in the source
code history leading up to the same point of interest.  The left side of Figure
\ref{fig:changeset-flt} illustrates the dual-document extraction approach.

The document extraction process for the snapshot remains the same as covered in
Section \ref{sec:method-background}, but may be modified to fit the task
required.  The document extractor for the changesets parses each changeset for
the removed, added, and context lines.  From there, the text extractor
tokenizes each line.  The same preprocessor transformations occur in both the
snapshot and changesets.  This helps ensure that the snapshot vocabulary is a
subset of the changeset vocabulary [@Corley-etal_2014].

The right side of Figure \ref{fig:changeset-flt} illustrates the retrieval
process.  The key intuition to our approach is that a topic model such as LDA
or LSI can infer *any* document's topic proportions regardless of the documents
used to train the model.  This is also what determining the topic proportions
of a user-created query has relied on in traditional TM-based FLTs or DITs.
Likewise, so are other unseen documents.  In our approach, the seen documents
are changesets and the unseen documents are the source code entities of the
snapshot.

Hence, we train a topic model on the changeset corpus and use the model to
index the snapshot corpus.  Note that we never construct an index of the
changeset documents used to train the model.  We only use the changesets to
continuously update the topic model and only use the snapshot for indexing.

To leverage the online functionality of the topic models, we can also intermix
the model training, indexing, and retrieval steps.  First, we initialize a
model in online mode.  We update the model with new changesets whenever a
developer makes a new commit.  That is, with changesets, we incrementally
update a model and can query it at any moment.  This allows for a *historical
simulation* of how a changeset-based approach would perform in a realistic
scenario.

#### Feature Location with Changeset Topics {#sec:flt-approach}

Application of the constructed changeset-based topic model for feature location
does not require any more work than described above.  The snapshot we will
index is a release version, and we have two options for this:  the release
source code package or the state of the source code repository at the commit
tagged with the corresponding release identifier.  We choose the latter option,
a snapshot, to ensure that the vocabulary of the indexed corpus is a subset of
the modeled corpus [@Corley-etal_2014], although the former option is entirely
possible.

#### Developer Identification with Changeset Topics {#sec:dit-approach}

![Developer identification using changesets\label{fig:changeset-triage}](figures/changeset-triage.pdf)

Application of the constructed changeset-based topic model for developer
identification varies slightly from the general approach, as seen in Figure
\ref{fig:changeset-triage}.  Following @Matter-etal_2009, each developer will
have their own document, or profile, consisting of each changeset they have
committed to the source code repository.  That is, the snapshot in this case is
a corpus of developer documents that consists of only words a particular
developer has changed.  As with our FLT, this ensures that each developer
profile indexed is a subset of the modeled corpus. There may be weighting
schemes to this [@Shokripour-etal_2013], such as only considering words which
they have added or removed, while ignoring context words.

#### Combo Changeset Topics {#sec:combo-approach}

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

\todo{re-write}

The changeset topic modeling approach requires three types of document
extraction: one for the snapshot of the state of source code at a commit of
interest, such as a tagged release; one for the every changeset in the source
code history leading up to that commit; and a developer profile of the words
each individual developer changed in those changesets.  The left side of Figure
\ref{fig:changeset-combo} illustrates the tri-document extraction approach.

The document extraction process for snapshot and changesets corpora remain the
same as covered in Section \ref{sec:flt-approach}.  The document extraction
process for the corpus of developer profiles remains the same as covered in
Section \ref{sec:dit-approach}.

The right side of Figure \ref{fig:changeset-combo} illustrates the retrieval
process.  For brevity, the queries and ranking do not appear in the diagram as
they remain the same as described for each search engine in their respective
sections, Sections \ref{sec:flt-approach} and \ref{sec:dit-approach}.  We train
a topic model on the changeset corpus and construct search engines for each
task separately.  In the source code search engine we build an index from the
snapshot corpus.  In the developer search engine we build an index from the
developer corpus.


### Why changesets?

We choose to train the model on changesets, rather than another source of
information, because they also represent what we are primarily interested in:
program features.  A single changeset gives us a view of an addition, removal,
or modification of a single feature.  A developer may, to some degree,
comprehend what a changeset accomplishes by examining it, much like examining a
source file \needcite.

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
containing the same source code entity only a few times -- perhaps only once.
Since topic modeling a snapshot only sees an entity once, topic modeling a
changeset can miss no information.

Using changesets also implies that the topic model may gain some noisy
information from these additional documents, especially when considering
removals.  However, @Vasa-etal_2007 also observe that code is less likely to be
removed than it is to be changed.  This implies that the noisy information
would likely remain in both snapshot-based models and changeset-based models.

Indeed, it would appear desirable to remove changesets from the model that are
old and no longer relevant.  There is no need for this because online LDA
already contains features for increasing the influence newer documents have on
the model, thereby decaying the affect of the older documents on the model.

## Study Design {#sec:study}

In this work, we introduce topic-modeling-based FLT and DIT in which we
incrementally build the model from source code *changesets*.  By training an
online learning algorithm using changesets, our FLT and DIT maintain up-to-date
models without incurring the non-trivial computational cost associated with
retraining the topic model.  

In this section we describe the design of our
study in which we compare our new methodology with the current practice.  We
describe the case study using the Goal-Question-Metric approach
[@Basili-etal_1994].

### Definition and Context {#sec:questions}

\todo{more}

For this work, we pose the following research questions:


\fonep
:   \foneq

\ftwop
:   \ftwoq

\donep
:   \doneq

\dtwop
:   \dtwoq

\conep
:   \coneq

\ctwop
:   \ctwoq

### Datasets and Benchmarks

For the first two Research Problems, there does exist various datasets and
benchmarks for each [@Dit-etal_2013; @Moreno-etal_2014; @Kagdi-etal_2012;
@Linares-Vasquez-etal_2012].  However, *Research Problem 3* (RP3) introduces a
complication to using these benchmarks.  RP3 requires high overlap of the
benchmarks.  The overlap of these benchmarks is small or non-existent, making
it difficult to determine whether a technique is performing well because of the
approach or if it happens to just be a challenging query for that technique.
We have created our own benchmark fit for evaluating both an FLT and DIT.

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
more accurate traceability link recovery [@Bissyande-etal_2013].  Finally, each
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
changed in the linked commit.  The second goldset is for evaluating DITs, and
contains the developer(s) that committed those changes.  We do not consider
whether the change was submitted by another developer and committed by a core
contributor.  In this case, we assume that the core contributor understands and
agrees with the change.

### Evaluation

#### FLT {#sec:flt-methodology}

For snapshots, the process is straightforward and corresponds to Figure
\ref{fig:snapshot-flt}.  We first train a model on the snapshot corpus using
batch training.  That is, the model can see all documents in the corpus at
once.  Then, we infer an index of topic distributions with the snapshot corpus.
For each query in the dataset, we infer the query's topic distribution and rank
each entity in the index with pairwise comparisons.

For changesets, the process varies slightly from a snapshot approach, as shown
in Figure \ref{fig:changeset-flt}.  First, we train a model of the changeset
corpus using batch training.  Second, we infer an index of topic distributions
with the snapshot corpus.  Note that we *do not* infer topic distributions with
the changeset corpus.  Finally, for each query in the dataset, we infer the
query's topic distribution and rank each entity in the snapshot index with
pairwise comparisons.

For the historical simulation, we must take a different approach.  We first
determine which commits relate to each query (or issue) and partition
mini-batches out of the changesets.  We then proceed by initializing a model
for online training with no initial corpus.  Using each mini-batch, or
partition, we update the model.  Then, we infer an index of topic distributions
with the snapshot corpus at the commit the partition ends on.  We also obtain a
topic distribution for each query related to the commit.  For each query, we
infer the query's topic distribution and rank each entity in the snapshot index
with pairwise comparisons.  Finally, we continue by updating the model with the
next mini-batch.

Since our dataset is extracted from the commit that implemented the change, our
partitioning is inclusive of that commit.  That is, we update the model with
the linked commit and infer the snapshot index from that commit.  This allows
our evaluations to capture any entities added to address the issue report, as
well as changed entities, but does not capture any entities removed by the
change.


#### DIT {#sec:dit-methodology}

For developer identification snapshots, our process requires two separate
steps.  First, we need to build a topic model for searching over the source
code snapshot (i.e., just like in the FLT evaluation).  Once we determine the
relevant documents, we need to determine which developer is the *owner* of
those documents.  To accomplish this, we turn to the source code history.
Following @Bird-etal_2011, we identify which developer has changed the
documents the most.  This implies that the snapshot approach is *dependent* on
the performance of the snapshot-based FLT.

For changesets, the approach will not necessarily be dependent on an FLT.  We
can utilize the same approach as we did for the FLT evaluation.  First, we
train a model of the changeset corpus using batch training.  Second, we infer
an index of topic distributions with the developer profiles.  Note that we *do
not* infer topic distributions with the changeset corpus used to train the
model.  Finally, for each query in the dataset, we infer the query's topic
distribution and rank each entity in the developer profiles index with pairwise
comparisons.

For the historical simulation, we take a slightly different approach.  We first
determine which commits relate to each query (or issue) and partition
mini-batches out of the changesets.  We then proceed by initializing a model
for online training.  Using each mini-batch, or partition, we update the model.
Then, we infer an index of topic distributions with the developer profiles at
the commit the partition ends on.  We also obtain a topic distribution for each
query related to the commit.  For each query, we infer the query's topic
distribution and rank each entity in the developer index with pairwise
comparisons.  Finally, we continue by updating the model with the next
mini-batch.



#### Combo  {#sec:combo-methodology}

In this work, we reuse the already-created framework from the previous two
research areas covered in this work.  We will not need to instantiate snapshot
models for this work.  Where this work will differ from the previous two
research areas is in how we construct the corpus and topic model.

For \cone, we want to find if the two approaches can rely on the same model
with minimal interference from one another's requirements.  For example, the
FLT task may perform better with less topics, while the DIT task may require
more topics for optimal performance.  Table \ref{table:combo-rq1} outlines the
factors about the model construction we will consider, giving us 48 possible
combinations.  The factors $\alpha$ and $\eta$ vary between several common
values, but also include automatic learning of these two hyper-parameters
[@Hoffman-etal_2010].  As in sections \ref{sec:flt} and \ref{sec:dit}, the
changeset corpus construction for \cone does not change and includes the entire
`diff`, but does not include the message.

\input{tables/case_study_factors}

While \cone{} focuses on model construction, \ctwo{} focuses on training-corpus
construction.  For \ctwo, there are several combinations to consider.  While
thus far we have always included the entire changeset when training, it may be
beneficial to consider only including portions (i.e., added lines only) while
excluding other portions (i.e., removed lines).  It may also be beneficial to
include the natural language text of the commit message.  Table
\ref{table:combo-rq2} outlines the 16 combinations over the 4 types of
changeset text.  One combination is invalid because it constructs an empty
corpus and thus impossible to train a topic model, leaving 15 total
combinations.



### Setting {#sec:setting}

Our document extraction process is shown on the left side of Figure
\ref{fig:changeset-flt}.  We implemented our document extractor in Python v2.7
using the [Dulwich library](http://www.samba.org/~jelmer/dulwich/) for
interacting with the source code repository.  We extract documents from both a
snapshot of the repository at a tagged snapshot and each commit reachable from
that tag's commit.  The same preprocessing steps are employed on all extracted
documents, regardless of corpus source.

To extract text from the changesets, we use the `git diff` between two commits.
In our changeset text extractor, we extract all text related to the change,
e.g., context, removed, and added lines; metadata, such as commit messages, are
ignored unless stated otherwise.  Note that we do not consider where the text
originates from, only that it is text changed by the commit.

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
topic models that may not be best-suited for each task on a particular subject
system.  This constraint gives us confidence that the measurements
collected are fair and that the results are not influenced by selective
parameter tweaking.  Again, our goal is to show the performance of the
changeset-based topic model against snapshot-based topic model under the same
conditions.  We do, however, adjust parameters during configuration sweeps for
RP3 and those are noted where appropriate.

Gensim's LDA implementation is based on an online LDA by @Hoffman-etal_2010 and
uses variational inference instead of a collapsed Gibbs sampler.  Unlike Gibbs
sampling, in order to ensure that the model converges for each document, we set
the model to take $1000$ iterations over a document during the inference step,
and as many passes over the corpus as needed until there is little improvement
in the evidence lower bound.  That is, we allow the model to behave as a batch,
or offline, model where possible.  We set the following LDA parameters for all
systems: $500$ topics, a symmetric $\alpha=1/K$, and a symmetric $\eta=1/K$.
These are default values for $\alpha$ and $\eta$ in Gensim, and have been found
to work well for the FLT task [@Biggers-etal_2015].  Again, we adjust all three
of these parameters for RP3.

For historical simulation (RP1 and RP2), since we must use online training, we
found it beneficial to consider two new parameters for online LDA: $\kappa$ and
$\tau_0$.  As noted in @Hoffman-etal_2010, it is beneficial to adjust $\kappa$
and $\tau_0$ to higher values for smaller mini-batches, e.g. a single
changeset.  These two parameters control how much influence a new mini-batch
has on the model when training.  We follow the recommendations in
@Hoffman-etal_2010, choosing $\tau_0=1024$ and $\kappa=0.9$ for all systems,
because the historical simulation often has mini-batch sizes in single digits.
Additionally, since we are operating in fully online mode, we cannot take
multiple passes over the entire corpus as that would defeat the purpose of a
historical simulation.

#### On LDA

\todo{Explain randomness and setting seed?}

### Data Collection and Analysis

#### Feature Location {#sec:flt-data-collection}

To evaluate the performance of a topic-modeling-based FLT we cannot use
measures such as precision and recall.  This is because the FLT creates
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs.  This effectiveness measure is the rank of the first relevant document
and represents the number of source code entities a developer would have to
view before reaching a relevant one.  Most importantly, this effectiveness
measure allows evaluating the FLT by using the mean reciprocal rank (MRR) and
the Wilcoxon signed-rank test.

To answer \fone, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{sec:flt-methodology}.  We then calculate the MRR
between the two sets of effectiveness measures.  We use the Wilcoxon
signed-rank test with Holm correction to determine the statistical significance
of the difference between the two rankings.  To answer \ftwo, we run the
historical simulation as outlined in Section \ref{sec:flt-methodology} and
compare it to the results of batch changesets from \fone using the same
measures.

We must note that when performing evaluations on FLTs, it is possible to
encounter a query that will fail to retrieve any related documents.  This is
related to both our approach and goldset extraction process.  Since our
approach indexes only on the snapshot corpus for a particular commit of
interest, it is possible that a file changed to fix a particular issue in the
goldset no longer exists or was never committed to source control by
maintainers.  We exclude these queries from all analysis.  One alternative to
exclusion would be to penalize the score by assigning maximum rank to the
failed query.  We choose exclusion over penalization as there is no evidence
supporting penalization to the best of our knowledge.

#### Developer Identification {#sec:dit-data-collection}

To evaluate the performance of a topic-modeling-based DIT we cannot use
measures such as precision and recall.  This is because the DIT creates
rankings pairwise, causing every developer to appear in the rankings.  Again,
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs, which is usable for a DIT.  The effectiveness measure is the rank of the
first relevant document and represents the number of developers the triager
would have to assign before choosing the right developer.  The effectiveness
measure allows evaluating the FLT by using the mean reciprocal rank (MRR).

To answer \done, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{sec:dit-methodology}.  We then calculate the MRR
between the two sets of effectiveness measures.  We use the Wilcoxon
signed-rank test with Holm correction to determine the statistical significance
of the difference between the two rankings.  To answer \dtwo, we run the
historical simulation as outlined in Section \ref{sec:dit-methodology} and
compare it to the results of batch changesets from \done.  Again, we calculate
the MRR and use the Wilcoxon signed-rank test.

#### Combining and Configuring Changeset-based Topic Models {#sec:combo-data-collection}

To evaluate the performance of a topic-modeling-based FLT and DIT we cannot use
measures such as precision and recall.  This is because each approach creates
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs, which is also applicable to DIT.  This effectiveness measure is the rank
of the first relevant document, whether that document represents a source code
entity or developer profile, and represents the number of documents entities a
developer or triager would have to view before reaching a relevant one.  Most
importantly, this effectiveness measure allows evaluating our approach by using
various rank-based metrics and statistical methods.

\todo{Should I break down \cone into two subquestions: model and corpus?}

For both research questions, we run the experiment of each task across all
possible configurations from two sets of configurations, shown in Tables
\ref{table:combo-rq1} and \ref{table:combo-rq2}.  The first set of
configurations varies the model parameters, while the second set of
configurations varies the corpus construction inclusion parameters.  Each set
is associated with a "default" configuration for the other, e.g., all
variations of model configurations use the same corpus configuration and vice
versa.  The default configurations are the same used throughout this thesis.
\todo{Need to explicitly say which configurations are used for all chapters!}

To answer \cone, we collect the effectiveness measures of each configuration
variation and use them calculate the MRR.  For each task, we create a pair of
effectiveness measures using the optimal configuration, where the optimal
configuration is the one with the highest MRR for that task.  For example, the
FLT result pair consists of the FLT configuration with the highest MRR as its
optimal configuration and the results of the same configuration for the DIT
task.  The DIT pairing is analogous.  We then use the Wilcoxon signed-rank test
with Holm correction to determine the statistical significance of the
difference between the optimal and alternative results for any given
configuration and task.

To answer \ctwo, we focus on configurations that vary the inclusion of text
sources used for corpus construction.  We use the same data that was collected,
but our statistical analysis will differ from \cone.  For each task, since we
have paired data across all 15 configurations, i.e., each configuration has
effectiveness measures for the same issues, we conduct a Friedman Chi-Square
($\chi^2$) test.  We perform post-hoc tests using Wilcoxon rank-sum test
to determine which configurations have an affect.

To determine whether including a particular text sources have an affect, we
turn to Mann-Whitney U tests.  We compare effectiveness measures of all ranks
when the text source is included against excluded.  We use Mann-Whitney here
because there is an unequal amount of results between a text source inclusion
and exclusion due to the invalid configuration of all text sources excluded.

\todo{------------------------------------------------------------------------}

\todo{anything after this point in the chapter is likely garbage}

\todo{------------------------------------------------------------------------}
