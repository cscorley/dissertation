## Study Design {#sec:combo-design}

In this work, we introduce a *combined* approach that allows for coalescing a
topic-modeling-based FLT and DIT coalesced into using the same topic model
built incrementally from source code *changesets*.  By training an online
learning algorithm using changesets and combining the two approaches, we
essentially cut the computational cost of the two tasks in *half* with a single
topic model.

### Approach

![Combining changeset-based feature location and developer identifiation
\label{fig:changeset-combo}](figures/changeset-combo.pdf)

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

### Evaluation

In this section we describe the design of a exploratory study in which we
determine whether a single topic model trained on changesets is fit to serve
two purposes.  For this work, we pose the following research questions:

\conep
:   \coneq

\ctwop
:   \ctwoq

#### Methodology {#sec:combo-methodology}

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
[@Hoffman-etal_2010].  As in Chapters \ref{chap:flt} and \ref{chap:dit}, the
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

#### Setting {#sec:combo-setting}

<!-- This is literally copied straight from FLT -->
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

#### Data Collection and Analysis {#sec:combo-data-collection}

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
($\chi^2$) test.  We then perform Wilcoxon signed-rank tests to determine which
inclusions have an affect, i.e., we compare effectiveness measures of all ranks
when the text source is included against excluded.
