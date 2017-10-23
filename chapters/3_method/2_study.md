## Study Design {#sec:study}

In this work, we introduce topic-modeling-based FLT and DIT in which we
incrementally build the model from source code changesets.  By training an
online learning algorithm using changesets, our FLT and DIT maintain up-to-date
models without incurring the non-trivial computational cost associated with
retraining a snapshot-based topic model from scratch.  In this section, we
describe the design of our study in which we compare our new methodology with
the current practice.  We describe the case study using the
Goal-Question-Metric approach [@Basili-etal_1994].

### Definition and Context {#sec:questions}

The primary goal of this work is to evaluate the performance and reliability of
topic models built on the source code histories, i.e., changeset-based topic
modeling, in order to move towards more robust approaches that can be utilized
by practitioners.  For this work, we pose the following research questions.
First, with respect to \frp, applying our approach to feature location, we ask:

\fonep
:   \foneq


\ftwop
:   \ftwoq

Then, for \drp, applying our approach to developer identification, we ask:

\donep
:   \doneq

\dtwop
:   \dtwoq

Finally, we determine for \crp whether we can gain model re-use for both tasks
by asking the following:

\conep
:   \coneq

\ctwop
:   \ctwoq


### Datasets and Benchmarks

For the first two Research Problems, there do exist various datasets and
benchmarks for each [@Dit-etal_2013; @Moreno-etal_2014; @Kagdi-etal_2012;
@Linares-Vasquez-etal_2012].  However, \crp introduces a complication to using
these benchmarks: requiring high overlap of the benchmarks.  The overlap of
these benchmarks is small or non-existent, making it difficult to determine
whether a technique is performing well because of the approach or if it happens
to just be a challenging query for that technique.  Further, these datasets
often only contain processed data, e.g., @Moreno-etal_2014 does not provide
original issue numbers of the extracted data.  We have created our own
benchmark fit for evaluating both an FLT and DIT.

The 6 subjects of our studies vary in size and application domain.
BookKeeper is a distributed logging service\footnote{\url{http://zookeeper.apache.org/bookkeeper/}}.
Mahout is a tool for scalable machine learning\footnote{\url{https://mahout.apache.org/}}.
OpenJPA is object-relational mapping tool\footnote{\url{http://openjpa.apache.org/}}.
Pig is a platform for analyzing large datasets\footnote{\url{http://pig.apache.org/}}.
Tika is a toolkit for extracting metadata and text from various types of files\footnote{\url{http://tika.apache.org/}}.
ZooKeeper is a tool that works as a coordination service to help build distributed applications\footnote{\url{http://zookeeper.apache.org}}.
Table \ref{table:subjects} summarizes the sizes of each system's corpora and
dataset.

\input{tables/subjects}

We chose these systems for our work because developers use descriptive commit
messages that allow for easy traceability-linking to issue reports.  These
systems are also studied by other researchers [@Moreno-etal_2014].  Further,
all projects use JIRA as an issue tracker, which has been found to encourage
more accurate traceability link recovery [@Bissyande-etal_2013].  Each system
varies in domain and in size, in terms of developers, changesets, and number of
source code files.

To build our dataset we mine the Git repository for information about each
commit: the committer, message, and files changed.  We use the files changed
information during the location-based approach.  Using the message, we extract
the traceability links to issues in JIRA with the case-insensitive regular
expression: `%s-\d+`, where `%s` is the project's name (e.g., BookKeeper).
This matches for JIRA-based issue identifiers, such as `BOOKKEEPER-439` or
`TIKA-42`.

From the issue reports, we extract the release version the issue marked as
fixed in.  We ignore issues that are not marked with a fixed version.  We also
extract the title and description of the issue, which will as our query for
that particular issue.

We construct two goldsets for each commit linked to an issue report.  The first
goldset is for evaluating FLTs, and contains the files, classes, and methods
changed in the linked commit.  The second goldset is for evaluating DITs, and
contains the developer(s) that committed those changes.  On occasion, an issue
will be addressed multiple times by two developers, and we consider both developers as
valid selections when ranking queries.  We do not consider the case when the
change was submitted by another developer as a patch, and then applied and
committed by a core contributor.  In this case, we assume that the core
contributor, being a subject matter expert, understands and agrees with the
change since they were the one that committed the changeset.

### Evaluation

#### Feature Location {#sec:flt-methodology}

To answer \fone, we evaluate two batch-trained models: one trained on a
snapshot corpus, and the other on a changeset corpus.

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

To answer \ftwo, for the historical simulation, we must take a different
approach.  We first determine which commits relate to each query (or issue) and
partition mini-batches out of the changesets.  We then proceed by initializing
a model for online training with no initial corpus.  We then update the model
with each mini-batch.  Then, we infer an index of topic distributions with the
snapshot corpus at the commit the partition ends on.  We also obtain a topic
distribution for each query related to the commit.  For each query, we infer
the query's topic distribution and rank each entity in the snapshot index with
pairwise comparisons.  Finally, we continue by updating the model with the next
mini-batch.

Since our dataset is extracted from the commit that implemented the change, our
partitioning is inclusive of that commit.  That is, we update the model with
the linked commit and infer the snapshot index from that commit.  This allows
our evaluations to capture any entities added to address the issue report, as
well as changed entities, but does not capture any entities removed by the
change.


#### Developer Identification {#sec:dit-methodology}

To answer \done, we take the approach described by @Matter-etal_2009, but
instead of using a VSM, we apply the approach using LDA.  This evaluation
requires a snapshot corpus, a changeset corpus, and a corpus of *developer
profiles*, as described in Section \ref{sec:dit-approach}.  Using the developer
profile approach rather than a heuristic-based approach, such as
@Bird-etal_2011, allows for us to construct a more fair evaluation of
batch-trained models by only varying the training corpus, i.e., the snapshot
corpus or the changeset corpus.

For developer identification using snapshots, we first build a topic model for
searching over the source code snapshot (i.e., like the FLT evaluation).  Then,
we infer an index of topic distributions with a corpus of developer profiles.
Note that we *do not* infer topic distributions with the snapshot corpus used
to train the model.  For each query in the dataset, we infer the query's topic
distribution and rank each entity in the index with pairwise comparisons.

For changesets, the process varies slightly from a snapshot approach, as shown
in Figure \ref{fig:changeset-triage}.  First, we train a model of the changeset
corpus using batch training.  Second, we infer an index of topic distributions
with the developer profiles.  Note, again, that we *do not* infer topic
distributions with the changeset corpus used to train the model.  Finally, for
each query in the dataset, we infer the query's topic distribution and rank
each entity in the developer profiles index with pairwise comparisons.

To answer \dtwo, the historical simulation, the approach is analogous of the
approach described in the previous section, Section \ref{sec:flt-methodology}.
The approach for developer identification, however, needs to vary from the
previous approach only with respect to indexing.  With each mini-batch, instead
of indexing a snapshot corpus of the commit at the end of the mini-batch, we
index of topic distributions with the developer profiles at that commit.  Note
that each developer profile of any mini-batch includes all developer activity
up to that commit, i.e., it is an aggregation of all previous mini-batches,
with the addition of activity since the last mini-batch.  The remainder of the
approach remains the same.

#### Combining and Configuring Changeset-based Topic Models {#sec:combo-methodology}

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
[@Hoffman-etal_2010].  As in sections \ref{sec:flt-methodology} and
\ref{sec:dit-methodology}, the changeset corpus construction for \cone does not
change and includes the entire `diff`, but does not include the message.

\input{tables/case_study_factors}

While \cone focuses on model construction, \ctwo focuses on training-corpus
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
snapshot of the repository at a tagged commit and each commit reachable from
that tag's commit.  The same preprocessing steps are employed on all extracted
documents, regardless of corpus source.

To extract text from the changesets, we use the `git diff` between two commits.
In our changeset text extractor, we extract all text related to the change,
e.g., context, removed, and added lines; metadata, such as commit messages, are
ignored unless stated otherwise.  Note that we do not consider where the text
originates from, only that it is text of the changeset.

After extracting tokens, we split the tokens based on camel case, underscores,
and non-letters.  We only keep the split tokens; original tokens are discarded
to remove duplication of information and keep the corpus vocabulary small.  We
normalize to lower case before filtering non-letters, English stop words
[@Fox_1992], Java keywords, and words shorter than three characters long.  We
do not stem words.

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
to work well for the FLT task [@Biggers-etal_2014].  Again, we adjust all three
of these parameters for \crps, but these values are used in all research
problems unless stated otherwise.

For historical simulation (\frps and \drps), since we must use online training,
we found it beneficial to consider two new parameters for online LDA: $\kappa$
and $\tau_0$.  As noted in @Hoffman-etal_2010, it is beneficial to adjust
$\kappa$ and $\tau_0$ to higher values for smaller mini-batches, e.g., a single
changeset.  These two parameters control how much influence a new mini-batch
has on the model when training.  We follow the recommendations in
@Hoffman-etal_2010, choosing $\tau_0=1024$ and $\kappa=0.9$ for all systems,
because the historical simulation often has mini-batch sizes in single digits.
Additionally, since we are operating in a truly online mode, we cannot take
multiple passes over the entire corpus as that would defeat the purpose of a
historical simulation.


\todo{Explain randomness and setting seed}

### Data Collection and Analysis

To evaluate the performance of a topic-modeling-based FLT and DIT we cannot use
measures such as precision and recall.  This is because each approach creates
rankings pairwise, causing every entity to appear in the rankings.
@Poshyvanyk-etal_2007 define an effectiveness measure for topic-modeling-based
FLTs, which is also applicable to DIT.  This effectiveness measure is the rank
of the first relevant document, whether that document represents a source code
entity or developer profile, and represents the number of documents entities a
developer or triager would have to view before reaching a relevant one.  Most
importantly, this effectiveness measure allows evaluating our approach by using
various rank-based metrics and statistical methods, such as the mean reciprocal
rank (MRR) and the Wilcoxon signed-rank test.

#### Feature Location {#sec:flt-data-collection}

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

To answer \done, we run the experiment on the snapshot and changeset corpora as
outlined in Section \ref{sec:dit-methodology}.  We then calculate the MRR
between the two sets of effectiveness measures.  We use the Wilcoxon
signed-rank test with Holm correction to determine the statistical significance
of the difference between the two rankings.  To answer \dtwo, we run the
historical simulation as outlined in Section \ref{sec:dit-methodology} and
compare it to the results of batch changesets from \done.  Again, we calculate
the MRR and use the Wilcoxon signed-rank test.

#### Combining and Configuring Changeset-based Topic Models {#sec:combo-data-collection}

For both research questions, we run the experiment of each task across all
possible configurations from two sets of configurations, shown in Tables
\ref{table:combo-rq1} and \ref{table:combo-rq2}.  The first set of
configurations varies the model parameters, while the second set of
configurations varies the corpus construction inclusion parameters.  Each set
is associated with a "default" configuration for the other, e.g., all
variations of model configurations use the same corpus configuration and vice
versa.  The default configurations are the same used throughout this thesis.

To answer \cone, we collect the effectiveness measures of each configuration
variation and use them calculate the MRR.  For each task, we create a pair of
effectiveness measures using the optimal configuration, where the optimal
configuration is the one with the highest MRR for that task.  For example, the
FLT result pair consists of the FLT configuration with the highest MRR as its
optimal configuration and the results of the same configuration for the DIT
task.  The DIT pairing is analogous.  We then use the Wilcoxon signed-rank test
with Holm correction to determine the statistical significance of the
difference between the optimal and alternate results for any given
configuration and task.

To answer \ctwo, we focus on configurations that vary the inclusion of text
sources used for corpus construction.  We use the same data that was collected,
but our statistical analysis will differ from \cone.  For each task, since we
have paired data across all 15 configurations, i.e., each configuration has
effectiveness measures for the same issues, we conduct a Friedman Chi-Square
($\chi^2$) test.  We perform post-hoc tests using Wilcoxon rank-sum test
to determine which configurations have an effect.

To determine whether including a particular text source has an effect, we
turn to Mann-Whitney U tests.  We compare effectiveness measures of all ranks
when the text source is included against excluded.  We use Mann-Whitney here
because there is an unequal amount of results between a text source inclusion
and exclusion due to the invalid configuration of all text sources excluded.
